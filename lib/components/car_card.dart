import 'package:car_renting/classes/car_class.dart';
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
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Builder(
              builder: (context) {
                final imageUrl = car.image;
                final id = car.id;

                // If no image, show placeholder
                if (imageUrl == null || imageUrl.isEmpty) {
                  return SvgPicture.asset(
                    'assets/images/no-image-car.svg',
                    key: ValueKey(id),
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.cover,
                  );
                }

                // SVG image
                if (imageUrl.toLowerCase().endsWith('.svg')) {
                  return SvgPicture.network(
                    imageUrl,
                    key: ValueKey(id),
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.cover,
                    placeholderBuilder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  );
                }

                // Other image formats (e.g., .webp, .png, .jpg)
                return Image.network(
                  imageUrl,
                  key: ValueKey(id),
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return SvgPicture.asset(
                      'assets/images/no-image-car.svg',
                      key: ValueKey(id),
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.cover,
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 10),
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
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/car-show',
                  arguments: {'selectedIndex': 1, 'car': car},
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
