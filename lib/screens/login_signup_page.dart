import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _pass = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  String _usernameFromEmail(String email) {
    final e = email.trim();
    if (!e.contains('@')) return e.isEmpty ? 'User' : e;
    return e.split('@').first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C0D0D),
        elevation: 0,
        title: const Text('Sign in'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 120),
            const Text(
              'Welcome Back',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 32),

            _inputField('Email address', controller: _email),
            const SizedBox(height: 16),
            _inputField('Password', controller: _pass, isPassword: true),
            const SizedBox(height: 28),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7A00),
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () {
                final username = _usernameFromEmail(_email.text);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage(username: username)),
                );
              },
              child: const Text('Sign in'),
            ),

            const Spacer(),

            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SignupPage()),
                );
              },
              child: const Text(
                "Don’t have an account? Sign up",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
