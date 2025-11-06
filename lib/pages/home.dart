import 'package:flutter/material.dart';
import 'package:car_renting/components/my_app_bar.dart';
import 'package:car_renting/components/my_navigation_bar.dart';
import 'package:car_renting/utils/navigation_helpers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final Color mainColor = const Color(0xFF941B1D);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (args != null) {
        final indexFromArgs = args['selectedIndex'] as int?;
        if (indexFromArgs != null && indexFromArgs != _selectedIndex) {
          setState(() {
            _selectedIndex = indexFromArgs;
          });
        }
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      handleNavigationTap(context, index);
    });
  }

  void _searchCars(String query) {
    if (query.trim().isEmpty) return;
    Navigator.pushNamed(
      context,
      '/cars',
      arguments: {'search': query.trim(), 'selectedIndex': 1},
    );
    _searchController.clear();
  }

  void _browseAllCars() {
    Navigator.pushNamed(context, '/cars', arguments: {'selectedIndex': 1});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Hero Section ---
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 220,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/hero-car.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 220,
                  color: Colors.black.withOpacity(0.45),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Find Your Perfect Ride',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Tajawal',
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Easy • Safe • Affordable',
                        style: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Tajawal',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // --- Search Bar ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onSubmitted: _searchCars,
                decoration: InputDecoration(
                  hintText: 'Search by brand or model...',
                  hintStyle: const TextStyle(fontFamily: 'Tajawal'),
                  prefixIcon: Icon(Icons.search, color: mainColor),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainColor, width: 1.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- Categories ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCategoryItem('Eco', 'assets/images/eco.png'),
                  _buildCategoryItem('Safety', 'assets/images/safety.png'),
                  _buildCategoryItem('Easy', 'assets/images/mobile.png'),
                ],
              ),
            ),

            const SizedBox(height: 35),

            // --- Browse All Cars Button ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: _browseAllCars,
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 3,
                ),
                child: const Center(
                  child: Text(
                    'Browse All Cars →',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: MyNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildCategoryItem(String label, String iconPath) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: mainColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Image.asset(iconPath, width: 50, height: 50, color: mainColor),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: mainColor,
          ),
        ),
      ],
    );
  }
}
