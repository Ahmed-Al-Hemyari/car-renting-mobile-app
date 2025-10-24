import 'package:car_renting/components/MyAppBar.dart';
import 'package:car_renting/services/User.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  final User user;

  const EditProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: double.infinity,
              height: 70,
            ),
            SizedBox(height: 45),
            Text(
              'UPDATE',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 30,
                letterSpacing: 5,
                fontWeight: FontWeight.bold,
                color: Color(0xFF941B1D),
              ),
            ),
            Text(
              'Update your profile',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      initialValue: user.name,
                      decoration: InputDecoration(
                        label: Text('Name'),
                        hintText: 'Enter you name',

                        prefixIcon: Icon(Icons.person),

                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 202, 202, 202),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 177, 177, 177),
                            width: 2,
                          ),
                        ),
                      ),

                      style: TextStyle(fontFamily: 'Tajawal', fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      initialValue: user.email,
                      decoration: InputDecoration(
                        label: Text('Email'),
                        hintText: 'Enter you email',
                        prefixIcon: Icon(Icons.email_outlined),

                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 202, 202, 202),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 177, 177, 177),
                            width: 2,
                          ),
                        ),
                      ),
                      style: TextStyle(fontFamily: 'Tajawal', fontSize: 20),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Color(0xFF941B1D),
                      ),
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(vertical: 8, horizontal: 60),
                      ),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ), // <-- border radius
                        ),
                      ),
                    ),
                    child: Text(
                      'Update',
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
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
