import 'package:car_renting/components/MyAppBar.dart';
import 'package:car_renting/components/MyNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:car_renting/services/Car.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Renting extends StatefulWidget {
  const Renting({super.key});

  @override
  State<Renting> createState() => _RentingState();
}

class _RentingState extends State<Renting> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          Navigator.pushReplacementNamed(
            context,
            '/',
            arguments: {'wantedRoute': '/home'},
          );
          break;
        case 1:
          Navigator.pushReplacementNamed(
            context,
            '/',
            arguments: {'wantedRoute': '/cars'},
          );
          break;
        case 2:
          Navigator.pushReplacementNamed(
            context,
            '/',
            arguments: {'wantedRoute': '/profile'},
          );
          break;
        default:
          Navigator.pushReplacementNamed(
            context,
            '/',
            arguments: {'wantedRoute': '/home'},
          );
      }
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
            if (car.image != '' && car.image!.isNotEmpty)
              (car.image!.toLowerCase().endsWith('.svg')
                  ? SvgPicture.asset(
                      'assets/images/${car.image}',
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/${car.image}',
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                    ))
            else
              SvgPicture.asset(
                'assets/images/no-image-car.svg',
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
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
        selectedIndex: 1,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
