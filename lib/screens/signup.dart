import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'login.dart';
import 'home.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();

  // GetX AuthController instance
  final AuthController auth = Get.find<AuthController>();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  void _signup() {
    final name = _name.text.trim();
    final email = _email.text.trim();
    final pass = _pass.text.trim();

    // Validate inputs
    if (name.isEmpty || email.isEmpty || pass.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in all fields",
        backgroundColor: const Color.fromARGB(255, 4, 39, 61),
        colorText: Colors.white,
      );
      return;
    }

    // Call signup in AuthController
    final success = auth.signup(name, email, pass);
    if (!success) {
      Get.snackbar(
        "Error",
        "User already exists",
        backgroundColor: const Color.fromARGB(255, 53, 140, 174),
        colorText: Colors.white,
      );
      return;
    }

    Get.snackbar(
      "Success",
      "Account created successfully!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Navigate to HomePage (username is reactive)
    Get.off(() => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8FC2D6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8FC2D6),
        elevation: 0,
        title: const Text('Sign up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 120),
            const Text(
              'Create Account',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),

            // Name field
            _inputField('Full Name', controller: _name),
            const SizedBox(height: 16),

            // Email field
            _inputField('Email address', controller: _email),
            const SizedBox(height: 16),

            // Password field
            _inputField('Password', controller: _pass, isPassword: true),
            const SizedBox(height: 28),

            // Signup button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 4, 39, 61),
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: _signup,
              child: const Text(
                'Create account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const Spacer(),

            // Link to login page
            TextButton(
              onPressed: () => Get.off(() => const LoginPage()),
              child: const Text(
                'Already have an account? Sign in',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Input field widget
  Widget _inputField(String hint,
      {required TextEditingController controller, bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
