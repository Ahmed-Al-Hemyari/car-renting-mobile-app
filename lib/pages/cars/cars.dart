import 'package:car_renting/components/my_app_bar.dart';
import 'package:car_renting/components/my_navigation_bar.dart';
import 'package:car_renting/classes/car_class.dart';
import 'package:car_renting/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:car_renting/components/car_card.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:car_renting/services/car_service.dart';

class Cars extends StatefulWidget {
  const Cars({super.key});

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  int _selectedIndex = 1;
  final String url = "http://10.0.2.2:8000/api/cars";
  final carService = CarService();

  String _searchQuery = '';
  String? _selectedBrand;
  String? _selectedCategory;
  double? _maxPrice;
  double? _minRate;

  late Future<List<Car>> _futureCars;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (args != null) {
        // Set navigation bar index if provided
        final indexFromArgs = args['selectedIndex'] as int?;
        if (indexFromArgs != null && indexFromArgs != _selectedIndex) {
          _selectedIndex = indexFromArgs;
        }

        // Set initial search query
        _searchQuery = args['search'] ?? '';
      }

      // Fetch cars with initial filters/search
      setState(() {
        _futureCars = _fetchCars();
      });
    });
  }

  Future<List<Car>> _fetchCars() async {
    return carService.CarIndex(
      url,
      search: _searchQuery,
      brand: _selectedBrand,
      category: _selectedCategory,
      maxPrice: _maxPrice,
      minRate: _minRate,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      handleNavigationTap(context, index);
    });
  }

  void _openFilters() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF941B1D),
                  ),
                ),
                const SizedBox(height: 20),

                // Brand
                DropdownButtonFormField<String>(
                  value: _selectedBrand,
                  hint: const Text('Select Brand'),
                  items: ['Toyota', 'BMW', 'Honda', 'Hyundai']
                      .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                      .toList(),
                  onChanged: (val) => setModalState(() => _selectedBrand = val),
                ),
                const SizedBox(height: 10),

                // Category
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  hint: const Text('Select Category'),
                  items: ['SUV', 'Sedan', 'Electric', 'Luxury']
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (val) =>
                      setModalState(() => _selectedCategory = val),
                ),
                const SizedBox(height: 10),

                // Max Price
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Max Price',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (val) => setModalState(
                    () => _maxPrice = double.tryParse(val) ?? _maxPrice,
                  ),
                ),
                const SizedBox(height: 10),

                // Minimum Rating
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Min Rating',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.star),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (val) => setModalState(
                    () => _minRate = double.tryParse(val) ?? _minRate,
                  ),
                ),

                const SizedBox(height: 20),

                // Apply Filters
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _futureCars = _fetchCars();
                    });
                  },
                  icon: const Icon(Icons.filter_alt),
                  label: const Text('Apply Filters'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF941B1D),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 45),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Our Cars",
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: _openFilters,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                  _futureCars = _fetchCars();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by brand or model...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF941B1D)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          Expanded(
            child: FutureBuilder<List<Car>>(
              future: _futureCars,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Failed to load cars'));
                }

                final cars = snapshot.data ?? [];
                if (cars.isEmpty) {
                  return const Center(child: Text('No cars found.'));
                }

                final cols = 2;
                final rows = (cars.length / cols).ceil();
                return Container(
                  color: Colors.grey[50],
                  padding: const EdgeInsets.all(8),
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
          ),
        ],
      ),
      bottomNavigationBar: MyNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
