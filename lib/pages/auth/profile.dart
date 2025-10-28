import 'package:car_renting/components/BookingCard.dart';
import 'package:car_renting/components/MyAppBar.dart';
import 'package:car_renting/components/MyNavigationBar.dart';
import 'package:car_renting/pages/loading.dart';
import 'package:car_renting/services/Booking.dart';
import 'package:car_renting/services/User.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
      // importing user
      final userMap = args['user'] as Map<String, User>? ?? {};
      final user = userMap.values.toList();
      // importing bookings
      final bookingsMap = args['bookings'] as Map<String, Booking>? ?? {};
      final bookings = bookingsMap.values.toList();
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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/no-image-user.jpg'),
                radius: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit, size: 18),
                  ),
                ],
              ),
              Text(
                user.email,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  fontFamily: 'Tajawal',
                ),
              ),
              // TextButton(
              //   onPressed: () {},
              //   child: Text(
              //     'Update Password',
              //     style: TextStyle(color: Color(0xFF941B1D)),
              //   ),
              // ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              'Total Bookings',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              '1',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Tajawal',
                                color: Colors.blue[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              'Active',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              '5',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Tajawal',
                                color: Colors.green[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              'Completed',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              '2',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Tajawal',
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    BookingCard(booking: booking1),
                    BookingCard(booking: booking2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
