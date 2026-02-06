import 'package:flutter/material.dart';
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

    // ✅ VALIDATION
    if (name.isEmpty || email.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // ✅ SUCCESS MESSAGE
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Account created successfully!"),
        backgroundColor: Colors.green,
      ),
    );

    // ✅ GO DIRECTLY TO HOME WITH USERNAME
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(username: name),
      ),
    );
  }

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

            _inputField('Full name', controller: _name),
            const SizedBox(height: 16),
            _inputField('Email address', controller: _email),
            const SizedBox(height: 16),
            _inputField('Password', controller: _pass, isPassword: true),

            const SizedBox(height: 28),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7A00),
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: _signup,
              child: const Text(
                'Create account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 24),

            // 🔥 Social icons (UI only)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialIcon(Icons.g_mobiledata, Colors.white24),
                const SizedBox(width: 20),
                _socialIcon(Icons.apple, Colors.black),
                const SizedBox(width: 20),
                _socialIcon(Icons.facebook, const Color(0xFF1877F2)),
              ],
            ),

            const Spacer(),

            // ✅ GO TO LOGIN PAGE
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

  Widget _socialIcon(IconData icon, Color bg) {
    return CircleAvatar(
      radius: 26,
      backgroundColor: bg,
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}
