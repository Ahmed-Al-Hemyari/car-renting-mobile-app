import 'package:car_renting/components/MyAppBar.dart';
import 'package:car_renting/components/MyNavigationBar.dart';
import 'package:car_renting/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:car_renting/services/Car.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Renting extends StatefulWidget {
  // final Car car;
  const Renting({super.key});

  @override
  State<Renting> createState() => _RentingState();
}

class _RentingState extends State<Renting> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      handleNavigationTap(context, index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    final Car car = arguments['car'] as Car;

    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[200],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Builder(
                builder: (context) {
                  final imageUrl = car.image;
                  final id = car.id;

                  if (imageUrl == null || imageUrl.isEmpty) {
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

            Text(
              '★ ${car.rate}',
              style: TextStyle(
                color: Colors.amber[800],
                fontSize: 17,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${car.brand} ${car.name}',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Container(
            //       height: 12,
            //       width: 12,
            //       margin: const EdgeInsets.only(right: 8),
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: car.availability
            //             ? Colors.green[400]
            //             : Colors.red[400],
            //       ),
            //     ),
            //     const SizedBox(width: 4),
            //     Center(
            //       child: Text(
            //         car.availability ? 'Available' : 'Unavailable',
            //         style: TextStyle(
            //           fontSize: 18,
            //           fontFamily: 'Tajawal',
            //           color: Colors.grey[800],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Text(
              '\$ ${car.price}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    '/',
                    arguments: {'car': car, 'wantedRoute': '/renting'},
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Color(0xFF941B1D)),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ), // <-- border radius
                    ),
                  ),
                ),
                child: Text('Rent'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
