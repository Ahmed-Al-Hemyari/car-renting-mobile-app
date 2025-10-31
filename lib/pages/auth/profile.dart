import 'package:car_renting/components/BookingCard.dart';
import 'package:car_renting/components/MyAppBar.dart';
import 'package:car_renting/components/MyNavigationBar.dart';
import 'package:car_renting/services/Booking.dart';
import 'package:car_renting/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 0;
  final String url = "http://10.0.2.2:8000/api/bookings";

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
      handleNavigationTap(context, index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FutureBuilder<List<Booking>>(
            future: Booking.bookingIndex(url),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Failed to load bookings'));
              }

              final bookings = snapshot.data ?? [];

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Ahmed',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit, size: 18),
                        ),
                      ],
                    ),
                    const Text(
                      'ahmed@gmail.com',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 10),

                    // Stats boxes
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

                    // Bookings list
                    ListView.builder(
                      shrinkWrap: true, // important
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
}
