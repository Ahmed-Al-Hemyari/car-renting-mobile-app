import 'package:car_renting/components/car_unavailable_calendar.dart';
import 'package:car_renting/components/my_app_bar.dart';
import 'package:car_renting/components/my_navigation_bar.dart';
import 'package:car_renting/classes/car_class.dart';
import 'package:car_renting/components/review_card.dart';
import 'package:car_renting/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CarShow extends StatefulWidget {
  // final Car car;
  const CarShow({super.key});

  @override
  State<CarShow> createState() => _CarShowState();
}

class _CarShowState extends State<CarShow> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    // Navigation Bar Management
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
      final indexFromArgs = args['selectedIndex'] as int?;
      if (indexFromArgs != null && indexFromArgs != _selectedIndex) {
        setState(() {
          _selectedIndex = indexFromArgs;
        });
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      handleNavigationTap(context, index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
        {};
    final car = args['car'] as Car?;
    print('Car: ${car?.name}, Rates: ${car?.rates}');

    if (car == null) {
      return Scaffold(body: Center(child: Text('Car not found!!')));
    }
    return Scaffold(
      appBar: MyAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Builder(
                  builder: (context) {
                    final imageUrl = car.image;
                    final id = car.id;

                    if (imageUrl.isEmpty) {
                      return SvgPicture.asset(
                        'assets/images/no-image-car.svg',
                        key: ValueKey(id),
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      );
                    }

                    if (imageUrl.toLowerCase().endsWith('.svg')) {
                      return SvgPicture.network(
                        imageUrl,
                        key: ValueKey(id),
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                        placeholderBuilder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      );
                    }

                    return Image.network(
                      imageUrl,
                      key: ValueKey(id),
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return SvgPicture.asset(
                          'assets/images/no-image-car.svg',
                          key: ValueKey(id),
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${car.brand} ${car.name}',
                style: const TextStyle(
                  fontSize: 27,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                car.category,
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  Text(
                    '★ ${car.rate}',
                    style: TextStyle(
                      color: Colors.amber[800],
                      fontSize: 21,
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${car.price} /Day',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CarUnavailableCalendar(unavailableDates: car.unavailableDates),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/renting',
                      arguments: {'car': car},
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Color(0xFF941B1D)),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child: const Text('Rent'),
                ),
              ),
              SizedBox(height: 20),
              Divider(thickness: 2),
              SizedBox(height: 20),
              Text(
                'Reviews',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                color: Colors.grey[50],
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    for (final rate in car.rates) ReviewCard(rate: rate),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
