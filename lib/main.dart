import 'package:car_renting/pages/auth/edit_profile.dart';
import 'package:car_renting/pages/auth/login.dart';
import 'package:car_renting/pages/auth/register.dart';
import 'package:car_renting/pages/auth/reset_password.dart';
import 'package:car_renting/pages/bookings/rate_page.dart';
import 'package:car_renting/pages/cars/car_show.dart';
import 'package:car_renting/pages/cars/cars.dart';
import 'package:car_renting/pages/home.dart';
import 'package:car_renting/pages/loading.dart';
import 'package:car_renting/pages/auth/profile.dart';
import 'package:car_renting/pages/bookings/renting.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => HomeScreen(),
        '/cars': (context) => Cars(),
        '/car-show': (context) => CarShow(),
        '/renting': (context) => Renting(),
        '/profile': (context) => Profile(),
        // Authentication
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/edit-profile': (context) => EditProfile(),
        '/reset-password': (context) => ResetPassword(),
        // Rating
        '/rating': (context) => RatePage(),
      },
    ),
  );
}
