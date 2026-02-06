import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/cart_controller.dart';
import 'controllers/auth_controller.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/splash.dart';
import 'pages/categories_page.dart';
import 'screens/home.dart';
import 'screens/medicne.dart';
import 'screens/vitamine.dart';

void main() {
  // Initialize controllers
  Get.put(CartController(), permanent: true);
  Get.put(AuthController(), permanent: true); // AuthController available globally
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // Start screen
      home: const SplashPage(),
      
      // Named routes
      getPages: [
        GetPage(name: '/categories', page: () => CategoriesPage()),
        GetPage(name: '/medicne', page: () => const OnboardingOne()),
        GetPage(name: '/vitamine', page: () => const OnboardingTwo()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/signup', page: () => const SignupPage()),
        GetPage(name: '/home', page: () => HomePage()), // username handled by AuthController
        GetPage(name: '/splash', page: () => const SplashPage()),
      ],
    );
  }
}
