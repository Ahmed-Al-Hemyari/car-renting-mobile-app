import 'package:car_renting/services/auth_service.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final _authService = AuthService();
    final _formKey = GlobalKey<FormState>();

    // Inputs Controllers
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    bool _isLoading = false;

    Future<void> _handleLogin() async {
      if (!_formKey.currentState!.validate()) return;

      setState(() => _isLoading = true);

      final result = await _authService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        url: "http://10.0.2.2:8000/api/login",
      );

      setState(() => _isLoading = false);

      if (result['success']) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Registration failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Scaffold(
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
              'LOGIN',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 30,
                letterSpacing: 5,
                fontWeight: FontWeight.bold,
                color: Color(0xFF941B1D),
              ),
            ),
            Text(
              'Login to access your account',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // 📧 Email
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    hint: 'Enter your email',
                    icon: Icons.email_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Enter your email';
                      if (!value.contains('@')) return 'Invalid email';
                      return null;
                    },
                  ),

                  // 🔒 Password
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hint: 'Enter your password',
                    icon: Icons.password_outlined,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF941B1D),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 80,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),

                  const SizedBox(height: 20),

                  // Don't have account?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(fontFamily: 'Tajawal', fontSize: 17),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                          context,
                          '/register',
                        ),
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 17,
                            color: Color(0xFF941B1D),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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
