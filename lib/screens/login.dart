import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home.dart';
import 'signup.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _pass = TextEditingController();

  // Use Get.find to get the AuthController instance
  final AuthController auth = Get.put(AuthController());

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  void _login() {
    final email = _email.text.trim();
    final pass = _pass.text.trim();

    // Validation
    if (email.isEmpty || pass.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in all fields",
        backgroundColor: const Color.fromARGB(255, 4, 39, 61),
        colorText: Colors.white,
      );
      return;
    }

    // For demo, any non-empty email/password logs in successfully
    auth.currentUser.value = email; // Save username/email

    Get.snackbar(
      "Success",
      "Logged in successfully!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Navigate to HomePage 
    Get.off(() => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 38, 52),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8FC2D6),
        elevation: 0,
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 120),
            const Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),

            _inputField('Email address', controller: _email),
            const SizedBox(height: 16),
            _inputField('Password', controller: _pass, isPassword: true),
            const SizedBox(height: 28),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 4, 39, 61),
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: _login,
              child: const Text(
                'Login',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const Spacer(),

            TextButton(
              onPressed: () {
                // Navigate to Signup page
                Get.off(() => const SignupPage());
              },
              child: const Text(
                'Don\'t have an account? Sign up',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(
    String hint, {
    required TextEditingController controller,
    bool isPassword = false,
  }) {
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
