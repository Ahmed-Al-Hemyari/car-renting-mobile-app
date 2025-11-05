import 'package:car_renting/classes/car_class.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final storage = FlutterSecureStorage();

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  // Loading Pages

  Future<void> _loadHomePage() async {
    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: {'selectedIndex': 0},
    );
  }

  Future<void> _loadCarsPage() async {
    Navigator.pushReplacementNamed(
      context,
      '/cars',
      arguments: {'selectedIndex': 1},
    );
  }

  Future<void> _loadCarShowPage() async {
    Navigator.pushReplacementNamed(
      context,
      '/car-show',
      arguments: {'selectedIndex': 1},
    );
  }

  Future<void> _loadRentingPage() async {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null || args['car'] == null) {
      print('No car found in arguments');
      return;
    }

    final Car car = args['car'] as Car;
    Navigator.pushNamed(context, '/renting', arguments: {'car': car});
  }

  Future<void> _loadProfilePage() async {
    Navigator.pushReplacementNamed(
      context,
      '/profile',
      arguments: {'selectedIndex': 2},
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};

      final wantedRoute = args['wantedRoute'] as String? ?? '/home';

      switch (wantedRoute) {
        case '/home':
          _loadHomePage();
          break;
        case '/cars':
          _loadCarsPage();
        case '/car-show':
          _loadCarShowPage();
          break;
        case '/renting':
          _loadRentingPage();
          break;
        case '/profile':
          _loadProfilePage();
          break;
        default:
          _loadHomePage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(child: SpinKitCubeGrid(color: Colors.grey[200])),
    );
  }
}
