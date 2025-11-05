import 'package:car_renting/components/my_app_bar.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

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
            // Text(
            //   'REGISTER',
            //   style: TextStyle(
            //     fontFamily: 'Tajawal',
            //     fontSize: 30,
            //     letterSpacing: 5,
            //     fontWeight: FontWeight.bold,
            //     color: Color(0xFF941B1D),
            //   ),
            // ),
            Text(
              'Reset you password',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Color(0xFF941B1D),
              ),
            ),
            SizedBox(height: 5),
            Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        label: Text('Old Password'),
                        hintText: 'Enter you old password',
                        prefixIcon: Icon(Icons.password),

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
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        label: Text('New Password'),
                        hintText: 'Enter you new password',
                        prefixIcon: Icon(Icons.password_outlined),

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
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        label: Text('Confirm New Password'),
                        hintText: 'Enter you new password again',
                        prefixIcon: Icon(Icons.password_outlined),

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
                  SizedBox(height: 20),
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
                      'Reset Password',
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
