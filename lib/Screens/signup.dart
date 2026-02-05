import 'package:flutter/material.dart';
import 'login.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C0D0D),
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

            _inputField('Full name'),
            const SizedBox(height: 16),
            _inputField('Email address'),
            const SizedBox(height: 16),
            _inputField('Password', isPassword: true),

            const SizedBox(height: 28),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7A00),
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () {},
              child: const Text('Create account'),
            ),

            const SizedBox(height: 24),

            // 🔥 Social icon buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialIcon(
                  icon: Icons.g_mobiledata,
                  color: Colors.white,
                  bg: Colors.white24,
                ),
                const SizedBox(width: 20),
                _socialIcon(
                  icon: Icons.apple,
                  color: Colors.white,
                  bg: Colors.black,
                ),
                const SizedBox(width: 20),
                _socialIcon(
                  icon: Icons.facebook,
                  color: Colors.white,
                  bg: Color(0xFF1877F2),
                ),
              ],
            ),

            const Spacer(),

            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
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

  Widget _inputField(String hint, {bool isPassword = false}) {
    return TextField(
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

  Widget _socialIcon({
    required IconData icon,
    required Color color,
    required Color bg,
  }) {
    return CircleAvatar(
      radius: 26,
      backgroundColor: bg,
      child: Icon(icon, color: color, size: 28),
    );
  }
}