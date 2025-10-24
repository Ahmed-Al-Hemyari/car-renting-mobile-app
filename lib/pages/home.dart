import 'package:car_renting/components/MyAppBar.dart';
import 'package:car_renting/components/MyNavigationBar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Navigation bar function

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
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/logo.png'), width: 120),
            SizedBox(height: 20),
            Text(
              'Explore Our Fleet',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(
                        0xFF941B1D,
                      ), // ripple and text color
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // keeps it compact
                      children: [
                        Image.asset(
                          'assets/images/eco.png',
                          width: 75,
                          height: 75,
                          color: const Color(0xFF941B1D),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Eco',
                          style: TextStyle(
                            color: Color(0xFF941B1D),
                            fontFamily: 'Tajawal',
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(
                        0xFF941B1D,
                      ), // ripple and text color
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // keeps it compact
                      children: [
                        Image.asset(
                          'assets/images/safety.png',
                          width: 75,
                          height: 75,
                          color: const Color(0xFF941B1D),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Safety',
                          style: TextStyle(
                            color: Color(0xFF941B1D),
                            fontFamily: 'Tajawal',
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(
                        0xFF941B1D,
                      ), // ripple and text color
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // keeps it compact
                      children: [
                        Image.asset(
                          'assets/images/mobile.png',
                          width: 75,
                          height: 75,
                          color: const Color(0xFF941B1D),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Easy',
                          style: TextStyle(
                            color: Color(0xFF941B1D),
                            fontFamily: 'Tajawal',
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
