import 'package:flutter/material.dart';
import '/screens/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0C0D0D),
        primaryColor: const Color(0xFFFF7A00),
      ),
      home: const SplashPage(),
    );
  }
}
