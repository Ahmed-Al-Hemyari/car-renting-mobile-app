import 'package:car_renting/services/Car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarCard extends StatelessWidget {
  final Car car;

  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[100],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (car.image != null && car.image!.isNotEmpty)
              ? (car.image!.toLowerCase().endsWith('.svg')
                    ? SvgPicture.network(
                        car.image!,
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.cover,
                        placeholderBuilder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      )
                    : Image.network(
                        car.image!,
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return SvgPicture.asset(
                            'assets/images/no-image-car.svg',
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                          );
                        },
                      ))
              : SvgPicture.asset(
                  'assets/images/no-image-car.svg',
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                ),

          Text(
            '${car.brand} ${car.name}',
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            car.category,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.w400,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),

          Column(
            children: [
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
                '\$${car.price} /Day',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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
          //         color: car.availability ? Colors.green[400] : Colors.red[400],
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
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/',
                  arguments: {'car': car, 'wantedRoute': '/car-show'},
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
              child: Text('Rent'),
            ),
          ),
        ],
      ),
    );
  }
}
