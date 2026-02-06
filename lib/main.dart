import 'package:flutter/material.dart';

// PAGES
import 'SCR/splash.dart';
import 'SCR/medicne.dart';
import 'SCR/vitamine.dart';
import 'SCR/login.dart';
import 'SCR/signup.dart';

void main() {
  runApp(const PharmyApp());
}

class PharmyApp extends StatelessWidget {
  const PharmyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pharmy',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0C0D0D),
        fontFamily: 'Roboto',
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF7A00),
          secondary: Color(0xFFFFC107),
        ),
      ),

      // 🔹 START SCREEN
      home: const SplashPage(),

      // OPTIONAL: Named routes (future use)
      routes: {
        '/onboarding1': (_) => const OnboardingOne(),
        '/onboarding2': (_) => const OnboardingTwo(),
        
        '/login': (_) => const LoginPage(),
        '/signup': (_) => const SignupPage(),
      },
    );
  }
}
