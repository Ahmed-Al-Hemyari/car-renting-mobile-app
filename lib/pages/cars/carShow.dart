import 'package:car_renting/components/MyAppBar.dart';
import 'package:car_renting/components/MyNavigationBar.dart';
import 'package:car_renting/services/Car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CarShow extends StatefulWidget {
  // final Car car;
  const CarShow({super.key});

  @override
  State<CarShow> createState() => _CarShowState();
}

class _CarShowState extends State<CarShow> {
  @override
  Widget build(BuildContext context) {
    // final arguments = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    // final Car car = arguments['car'] as Car;
    // List<DateTime> unavailableDays = [];

    // for (var period in car.unavailableDates) {
    //   DateTime currentDate = period.startDate;

    //   while (!currentDate.isAfter(period.endDate)) {
    //     unavailableDays.add(currentDate);
    //     currentDate.add(Duration(days: 1));
    //   }
    // }

    // bool _isUnavailable(DateTime day) {
    //   return unavailableDays.any(
    //     (d) => d.year == day.year && d.month == day.month && d.day == day.day,
    //   );
    // }

    // final Set<DateTime> days = {};
    //

    return Scaffold(
      appBar: MyAppBar(),
      body: Center(child: Text('Car Page')),
    );
  }
}


// return Scaffold(
    //   appBar: MyAppBar(),
    //   body: Center(
    //     child: Container(
    //       // padding: EdgeInsets.all(10),
    //       color: Colors.grey[50],
    //       // // decoration: BoxDecoration(
    //       // //   shape: BorderRadius.circular(15),
    //       // // ),
    //       child: Expanded(
    //         child: ListView(
    //           children: [
    //             Column(
    //               children: [
    //                 if (car.image != '' &&
    //                     car.image!.isNotEmpty &&
    //                     car.image != null)
    //                   (car.image!.toLowerCase().endsWith('.svg')
    //                       ? SvgPicture.asset(
    //                           'assets/images/${car.image}',
    //                           width: double.infinity,
    //                           height: 300,
    //                           fit: BoxFit.cover,
    //                         )
    //                       : Image.asset(
    //                           'assets/images/${car.image}',
    //                           width: double.infinity,
    //                           height: 300,
    //                           fit: BoxFit.cover,
    //                         ))
    //                 else
    //                   SvgPicture.asset(
    //                     'assets/images/no-image-car.svg',
    //                     width: double.infinity,
    //                     height: 300,
    //                     fit: BoxFit.cover,
    //                   ),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(
    //                     vertical: 15.0,
    //                     horizontal: 50,
    //                   ),
    //                   child: Divider(thickness: 2),
    //                 ),
    //                 Text(
    //                   '★ ${car.rate}',
    //                   style: TextStyle(
    //                     color: Colors.amber[800],
    //                     fontSize: 20,
    //                     fontFamily: 'Tajawal',
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 Text(
    //                   '${car.brand} ${car.name}',
    //                   style: TextStyle(
    //                     fontSize: 33,
    //                     fontFamily: 'Tajawal',
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                   textAlign: TextAlign.center,
    //                 ),
    //                 Text(
    //                   car.category,
    //                   style: TextStyle(
    //                     fontSize: 25,
    //                     fontFamily: 'Tajawal',
    //                     fontWeight: FontWeight.w400,
    //                     color: Colors.grey[700],
    //                   ),
    //                   textAlign: TextAlign.center,
    //                 ),
    //                 Text(
    //                   '\$${car.price} /Day',
    //                   style: TextStyle(
    //                     color: Colors.grey[700],
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(
    //                     vertical: 10,
    //                     horizontal: 20,
    //                   ),
    //                   // child: TableCalendar(
    //                   //   focusedDay: DateTime.now(),
    //                   //   firstDay: DateTime(2025, 1, 1),
    //                   //   lastDay: DateTime(2040, 12, 31),
    //                   //   calendarBuilders: CalendarBuilders(
    //                   //     defaultBuilder: (context, day, focusedDay) {
    //                   //       if (_isUnavailable(day)) {
    //                   //         return Container(
    //                   //           margin: const EdgeInsets.all(6.0),
    //                   //           decoration: BoxDecoration(
    //                   //             color: Colors.redAccent.withOpacity(0.5),
    //                   //             shape: BoxShape.circle,
    //                   //           ),
    //                   //           child: Center(
    //                   //             child: Text(
    //                   //               '${day.day}',
    //                   //               style: const TextStyle(color: Colors.white),
    //                   //             ),
    //                   //           ),
    //                   //         );
    //                   //       }
    //                   //       return null;
    //                   //     },
    //                   //   ),
    //                   // ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );