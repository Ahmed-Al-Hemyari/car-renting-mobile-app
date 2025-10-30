import 'package:car_renting/components/MyAppBar.dart';
import 'package:car_renting/components/MyNavigationBar.dart';
import 'package:car_renting/services/Car.dart';
import 'package:car_renting/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:car_renting/components/CarCard.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class Cars extends StatefulWidget {
  const Cars({super.key});

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  int _selectedIndex = 0;
  final String url = "http://10.0.2.2:8000/api/cars";

  @override
  void initState() {
    super.initState();

    // Navigation Bar Management
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
      handleNavigationTap(context, index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: FutureBuilder<List<Car>>(
        future: Car.carIndex(url),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Failed to load cars'));
          }
          final cars = snapshot.data ?? [];
          final cols = 2;
          final rows = (cars.length / cols).ceil();
          return Container(
            color: Colors.grey[50],
            padding: EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: LayoutGrid(
                columnSizes: List.filled(cols, 1.fr),
                rowSizes: List.filled(rows, auto),
                rowGap: 8,
                columnGap: 8,
                children: [for (final car in cars) CarCard(car: car)],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: MyNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
