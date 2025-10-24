import 'package:car_renting/components/MyAppBar.dart';
import 'package:car_renting/components/MyNavigationBar.dart';
import 'package:car_renting/services/Car.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:car_renting/components/CarCard.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class Cars extends StatefulWidget {
  const Cars({super.key});

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
      final indexFromArgs = args['selectedIndex'] as int?;
      if (indexFromArgs != null && indexFromArgs != _selectedIndex) {
        setState(() {
          _selectedIndex = indexFromArgs;
        });
      }
    });
  }

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
    // Navigation bar function

    // imported data
    final arguments = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    final carsMap = arguments['cars'] as Map<String, Car>? ?? {};
    final cars = carsMap.values.toList();
    // final List<dynamic> carData = arguments['cars'] ?? [];
    // final List<Car> cars = carData.map((item) => Car.fromJson(item)).toList();

    // grid variables
    final cols = 2;
    final rows = (cars.length / cols).ceil();

    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        color: Colors.grey[50],
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: LayoutGrid(
            columnSizes: List.filled(cols, 1.fr),
            rowSizes: List.filled(rows, auto),
            rowGap: 8,
            columnGap: 8,
            children: [
              for (final car in cars)
                CarCard(
                  car: car,
                  // imagePath: car['image'] ?? 'no-image-car.svg',
                  // name: '${car['brand']} ${car['name']}',
                  // category: car['category'] ?? 'Unknown',
                  // availability: true,
                  // rate: double.tryParse('${car['rate']}') ?? 0,
                  // price: double.tryParse('${car['price']}') ?? 0,
                ),
            ],
          ),
        ),

        // child: GridView.builder(
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     crossAxisSpacing: 8,
        //     mainAxisSpacing: 8,
        //     childAspectRatio: 0.75,
        //   ),
        //   itemCount: cars.length,
        //   itemBuilder: (context, index) {
        //     final car = cars[index];
        //     return CarCard(
        //       imagePath: car['image'] ?? 'hero-car.png',
        //       name: '${car['brand']} ${car['name']}',
        //       category: car['category'] ?? 'Unknown',
        //       availability: true,
        //       rate: double.tryParse('${car['rate']}') ?? 0,
        //       price: double.tryParse('${car['price']}') ?? 0,
        //     );
        //   },
        // ),
      ),
      bottomNavigationBar: MyNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
