import 'package:car_renting/components/booking_card.dart';
import 'package:car_renting/components/my_app_bar.dart';
import 'package:car_renting/components/my_navigation_bar.dart';
import 'package:car_renting/classes/booking_class.dart';
import 'package:car_renting/classes/user_class.dart';
import 'package:car_renting/services/auth_service.dart';
import 'package:car_renting/services/booking_service.dart';
import 'package:car_renting/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 2;
  final authService = AuthService();
  final bookingService = BookingService();

  /// Combined async function to load user and bookings
  Future<Map<String, dynamic>> _loadProfileData() async {
    final User? user = await authService.getUser();
    if (user == null) throw Exception('User not logged in');

    final List<Booking> bookings = await bookingService.BookingIndex(
      'http://10.0.2.2:8000/api/bookings/user/${user.id}',
    );

    return {'user': user, 'bookings': bookings};
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      handleNavigationTap(context, index);
    });
  }

  Widget _buildStatBox({
    required String title,
    required String value,
    required Color color,
    required Color bgColor,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Tajawal',
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FutureBuilder<Map<String, dynamic>>(
            future: _loadProfileData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final user = snapshot.data!['user'] as User;
              final bookings = snapshot.data!['bookings'] as List<Booking>;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/no-image-user.jpg',
                      ),
                      radius: 40.0,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/edit-profile',
                              arguments: {'user': user},
                            );
                          },
                          icon: const Icon(Icons.edit, size: 18),
                        ),
                      ],
                    ),
                    Text(
                      user.email,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        authService.logout();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/login',
                          (route) => false,
                        );
                      },
                      label: const Text('Logout'),
                      icon: const Icon(Icons.exit_to_app),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        foregroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatBox(
                          title: 'Total Bookings',
                          value: bookings.length.toString(),
                          color: Colors.blue[600]!,
                          bgColor: Colors.blue[50]!,
                        ),
                        const SizedBox(width: 10),
                        _buildStatBox(
                          title: 'Active',
                          value: bookings
                              .where((b) => b.status == 'active')
                              .length
                              .toString(),
                          color: Colors.green[600]!,
                          bgColor: Colors.green[50]!,
                        ),
                        const SizedBox(width: 10),
                        _buildStatBox(
                          title: 'Completed',
                          value: bookings
                              .where((b) => b.status == 'completed')
                              .length
                              .toString(),
                          color: Colors.grey[700]!,
                          bgColor: Colors.grey[100]!,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    bookings.isEmpty
                        ? Column(
                            children: [
                              const SizedBox(height: 60),
                              const Text(
                                "You haven't booked any car yet",
                                style: TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 25),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/cars',
                                    (route) => false,
                                    arguments: {'selectedIndex': 1},
                                  );
                                },
                                label: const Text('Explore Cars'),
                                icon: const Icon(Icons.explore),
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    const Color(0xFF941B1D),
                                  ),
                                  foregroundColor: WidgetStateProperty.all(
                                    Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: bookings.length,
                            itemBuilder: (context, index) =>
                                BookingCard(booking: bookings[index]),
                          ),
                  ],
                ),
              );
            },
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
