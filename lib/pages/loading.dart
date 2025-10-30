import 'package:car_renting/services/Booking.dart';
import 'package:car_renting/services/Car.dart';
import 'package:car_renting/services/User.dart';
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
    try {
      // final data = await getCars();
      // final cars = <String, Car>{'car1': car1, 'car2': car2};
      Navigator.pushReplacementNamed(
        context,
        '/car-show',
        arguments: {'car': car1, 'selectedIndex': 1},
      );
    } catch (e) {
      print('Error: $e');
    }
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
      arguments: {'selectedIndex': 2, 'user': user},
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

// example data
final car1 = Car(
  image: '',
  brand: 'Toyota',
  name: 'Prado',
  category: 'SUV',
  price: 100,
  rate: 4.5,
  unavailableDates: [
    // Period(startDate: DateTime(2025, 9, 25), endDate: DateTime(2025, 10, 2)),
    // Period(startDate: DateTime(2025, 10, 5), endDate: DateTime(2025, 10, 10)),
    // Period(startDate: DateTime(2025, 10, 15), endDate: DateTime(2025, 10, 20)),
  ],
);
final car2 = Car(
  image: '',
  brand: 'Toyota',
  name: 'Land Cruiser',
  category: 'SUV',
  price: 150,
  rate: 4.6,
  unavailableDates: [
    // Period(startDate: DateTime(2025, 9, 25), endDate: DateTime(2025, 9, 2)),
    // Period(startDate: DateTime(2025, 10, 5), endDate: DateTime(2025, 10, 10)),
    // Period(startDate: DateTime(2025, 10, 15), endDate: DateTime(2025, 10, 20)),
  ],
);

final user = User(name: 'Ahmed', email: 'ahmed@gmail.com');

final booking1 = Booking(
  id: 1,
  carImage: '',
  carName: 'Toyota Prado',
  carCategory: 'SUV',
  startDate: DateTime(2025, 10, 20),
  endDate: DateTime(2025, 10, 25),
  status: 'pending',
  rated: false,
);
final booking2 = Booking(
  id: 1,
  carImage: '',
  carName: 'Toyota Land Cruiser',
  carCategory: 'SUV',
  startDate: DateTime(2025, 10, 21),
  endDate: DateTime(2025, 10, 23),
  status: 'completed',
  rated: false,
);
