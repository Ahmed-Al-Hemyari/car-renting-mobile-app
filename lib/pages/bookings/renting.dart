import 'dart:ui';

import 'package:car_renting/components/my_app_bar.dart';
import 'package:car_renting/components/my_navigation_bar.dart';
import 'package:car_renting/services/auth_service.dart';
import 'package:car_renting/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:car_renting/classes/car_class.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Renting extends StatefulWidget {
  // final Car car;
  const Renting({super.key});

  @override
  State<Renting> createState() => _RentingState();
}

class _RentingState extends State<Renting> {
  final authService = AuthService();

  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      handleNavigationTap(context, index);
    });
  }

  // Date Picker
  DateTime? _startDate;
  DateTime? _endDate;
  int? _totalDays;
  final _notes = TextEditingController();

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      setState(() {
        if (isStart) {
          _startDate = selectedDate;
        } else {
          _endDate = selectedDate;
        }

        // Calculate total days only if both dates are selected
        if (_startDate != null && _endDate != null) {
          final diff = _endDate!.difference(_startDate!).inDays;
          _totalDays = diff >= 0 ? diff : 0;
        } else {
          _totalDays = 0;
        }
      });
    }
  }

  void _createBooking(BuildContext context, String url, dynamic car) async {
    if (_startDate == null || _endDate == null || _totalDays == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select valid start and end dates'),
        ),
      );
      return;
    }

    final user = await authService.getUser();
    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('User not logged in')));
      return;
    }

    try {
      final token = await authService.getToken();

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'user_id': user.id,
          'car_id': car.id,
          'start_date': _startDate!.toIso8601String(),
          'end_date': _endDate!.toIso8601String(),
          'total_days': _totalDays,
          'notes': _notes.text.trim(),
        }),
      );

      final jsonResponse = jsonDecode(response.body);
      print('📦 Response: $jsonResponse');

      if (!context.mounted) return;

      if (response.statusCode == 200 && jsonResponse['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              jsonResponse['message'] ?? 'Booking created successfully!',
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );

        await Future.delayed(const Duration(seconds: 2));

        if (!context.mounted) return;
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/profile',
          (Route<dynamic> route) => false,
          arguments: {'selectedIndex': 2},
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              jsonResponse['message'] ?? 'Failed to create booking',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('⚠️ Error creating booking: $e');
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Network error. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    final Car car = arguments['car'] as Car;

    final _formKey = GlobalKey<FormState>();
    final String url = 'http://10.0.2.2:8000/api/bookings';
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[200],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Builder(
                  builder: (context) {
                    final imageUrl = car.image;
                    final id = car.id;

                    if (imageUrl == null || imageUrl.isEmpty) {
                      return SvgPicture.asset(
                        'assets/images/no-image-car.svg',
                        key: ValueKey(id),
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      );
                    }

                    if (imageUrl.toLowerCase().endsWith('.svg')) {
                      return SvgPicture.network(
                        imageUrl,
                        key: ValueKey(id),
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                        placeholderBuilder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      );
                    }

                    return Image.network(
                      imageUrl,
                      key: ValueKey(id),
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return SvgPicture.asset(
                          'assets/images/no-image-car.svg',
                          key: ValueKey(id),
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 15),
              Text(
                '★ ${car.rate}',
                style: TextStyle(
                  color: Colors.amber[800],
                  fontSize: 17,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${car.brand} ${car.name}',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '\$ ${car.price}',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Start Date Field
                          GestureDetector(
                            onTap: () => _selectDate(context, true),
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Start Date',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                prefixIcon: const Icon(Icons.calendar_month),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                              child: Text(
                                _startDate == null
                                    ? 'Select start date'
                                    : '${_startDate!.toLocal()}'.split(' ')[0],
                                style: TextStyle(
                                  color: _startDate == null
                                      ? Colors.grey
                                      : Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // End Date Field
                          GestureDetector(
                            onTap: () => _selectDate(context, false),
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'End Date',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                prefixIcon: const Icon(Icons.calendar_month),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                              child: Text(
                                _endDate == null
                                    ? 'Select end date'
                                    : '${_endDate!.toLocal()}'.split(' ')[0],
                                style: TextStyle(
                                  color: _endDate == null
                                      ? Colors.grey
                                      : Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          SizedBox(
                            width: double.infinity,
                            child: _buildTextField(
                              controller: _notes,
                              label: 'Notes',
                              hint: 'Type any additional notes here...',
                              icon: Icons.notes,
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return 'Type any additional notes here...';
                                return null;
                              },
                            ),
                          ),

                          const SizedBox(height: 15),

                          // Rental Summary
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Rental Summary',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Days: ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      _totalDays != null
                                          ? _totalDays!.toString()
                                          : '0',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF941B1D),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Price: ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '\$ ${_totalDays != null ? _totalDays! * car.price : 0}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF941B1D),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Confirm Booking'),
                                      content: Text(
                                        'Are you sure you want to confirm this booking?',
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(
                                              context,
                                            ).pop(false); // User canceled
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(
                                              context,
                                            ).pop(true); // User confirmed
                                          },
                                          child: Text('Confirm'),
                                        ),
                                      ],
                                    );
                                  },
                                ).then((confirmed) {
                                  if (confirmed != null && confirmed) {
                                    _createBooking(context, url, car);
                                  } else {
                                    return;
                                  }
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  Color(0xFF941B1D),
                                ),
                                foregroundColor: WidgetStateProperty.all(
                                  Colors.white,
                                ),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              child: Text('Confirm'),
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
      ),
      bottomNavigationBar: MyNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 177, 177, 177),
              width: 2,
            ),
          ),
        ),
        style: const TextStyle(fontFamily: 'Tajawal', fontSize: 20),
      ),
    );
  }
}
