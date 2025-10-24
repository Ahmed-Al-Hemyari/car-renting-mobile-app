import 'package:car_renting/components/MyAppBar.dart';
import 'package:car_renting/services/Car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CarShow extends StatelessWidget {
  final Car car;
  const CarShow({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    List<DateTime> UnavailableDays = [];

    for (var period in car.unavailableDates) {
      DateTime currentDate = period.startDate;

      while (!currentDate.isAfter(period.endDate)) {
        UnavailableDays.add(currentDate);
        currentDate.add(Duration(days: 1));
      }
    }
    // final Set<DateTime> days = {};
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: Container(
          // padding: EdgeInsets.all(10),
          color: Colors.grey[50],
          // // decoration: BoxDecoration(
          // //   shape: BorderRadius.circular(15),
          // // ),
          child: Expanded(
            child: ListView(
              children: [
                Column(
                  children: [
                    if (car.image != '' &&
                        car.image!.isNotEmpty &&
                        car.image != null)
                      (car.image!.toLowerCase().endsWith('.svg')
                          ? SvgPicture.asset(
                              'assets/images/${car.image}',
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/${car.image}',
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.cover,
                            ))
                    else
                      SvgPicture.asset(
                        'assets/images/no-image-car.svg',
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 50,
                      ),
                      child: Divider(thickness: 2),
                    ),
                    Text(
                      '★ ${car.rate}',
                      style: TextStyle(
                        color: Colors.amber[800],
                        fontSize: 20,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${car.brand} ${car.name}',
                      style: TextStyle(
                        fontSize: 33,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      car.category,
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '\$${car.price} /Day',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: CalendarDatePicker(
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2030),
                        onDateChanged: (_) {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
