import 'package:flutter/material.dart';
import 'package:car_renting/components/my_app_bar.dart';
import 'package:car_renting/classes/user_class.dart';
import 'package:car_renting/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late User _user;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  bool _submitting = false;
  bool _isInitialized = false;

  final authService = AuthService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (args != null && args['user'] != null) {
        _user = args['user'] as User;

        _nameController = TextEditingController(text: _user.name);
        _emailController = TextEditingController(text: _user.email);
      } else {
        _nameController = TextEditingController();
        _emailController = TextEditingController();
      }

      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name and Email cannot be empty')),
      );
      return;
    }

    setState(() => _submitting = true);

    try {
      final token = await authService.getToken();
      final url = Uri.parse(
        'http://10.0.2.2:8000/api/users/update/${_user.id}',
      );
      final res = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'name': name, 'email': email}),
      );

      if (res.statusCode == 200) {
        // final decoded = jsonDecode(res.body);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );

        // Update local user object
        _user = User(
          id: _user.id,
          name: name,
          email: email,
          // copy other fields if any
        );

        // Return updated user to previous screen
        Navigator.pop(context, _user);
      } else {
        final decoded = jsonDecode(res.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Update failed: ${decoded['message'] ?? res.body}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = const Color(0xFF941B1D);

    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset('assets/images/logo.png', width: 150, height: 70),
            const SizedBox(height: 30),
            const Text(
              'Update Your Profile',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF941B1D),
              ),
            ),
            const SizedBox(height: 10),
            Form(
              child: Column(
                children: [
                  // Name
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        prefixIcon: const Icon(Icons.person),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  // Email
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _submitting ? null : _updateProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _submitting
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Update',
                              style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
