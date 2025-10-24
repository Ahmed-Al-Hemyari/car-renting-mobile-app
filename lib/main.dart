import 'package:car_renting/pages/auth/edit_profile.dart';
import 'package:car_renting/pages/auth/login.dart';
import 'package:car_renting/pages/auth/register.dart';
import 'package:car_renting/pages/auth/reset_password.dart';
import 'package:car_renting/pages/cars/carShow.dart';
import 'package:car_renting/pages/cars/cars.dart';
import 'package:car_renting/pages/home.dart';
import 'package:car_renting/pages/loading.dart';
import 'package:car_renting/pages/auth/profile.dart';
import 'package:car_renting/pages/bookings/renting.dart';
import 'package:car_renting/services/Car.dart';
import 'package:car_renting/services/User.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/car-show',
      routes: {
        // '/': (context) => Loading(),
        '/home': (context) => HomeScreen(),
        '/cars': (context) => Cars(),
        '/car-show': (context) => CarShow(car: car2),
        '/renting': (context) => Renting(),
        '/profile': (context) => Profile(),
        // Authentication
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/edit-profile': (context) => EditProfile(user: user),
        '/reset-password': (context) => ResetPassword(),
      },
    ),
  );
}

User user = User(name: 'Ahmed', email: 'ahmed@gmail.com');
// Car car = Car(
//   image: 'image',
//   brand: 'Toyota',
//   name: 'Prado',
//   category: 'SUV',
//   price: 100,
//   rate: 4.2,
// );
