import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/cart_controller.dart';
import 'pages/categories_page.dart';

// SCREENS
import 'SCR/splash.dart';
import 'SCR/login.dart';
import 'SCR/signup.dart';
import 'SCR/medicne.dart';
import 'SCR/vitamine.dart';

void main() {
  // ✅ Keep CartController always alive
  Get.put(CartController(), permanent: true);

  runApp(const PharmyApp());
}

class PharmyApp extends StatelessWidget {
  const PharmyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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

      // ✅ Start screen
      home: const SplashPage(),

      // ✅ Routes (GetX)
      getPages: [
        GetPage(name: '/', page: () => const SplashPage()),
        GetPage(name: '/splash', page: () => const SplashPage()),

        GetPage(name: '/categories', page: () => CategoriesPage()),
        GetPage(name: '/medicine', page: () => const MedicinePage()),
        GetPage(name: '/vitamine', page: () => const VitaminePage()),

        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/signup', page: () => const SignupPage()),
      ],
    );
  }
}
