import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/cart_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/theme_controller.dart';

import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/splash.dart';
import 'pages/categories_page.dart';
import 'screens/medicne.dart';
import 'screens/vitamine.dart';
import 'screens/home.dart';
import 'pages/dashboard_page.dart';
import 'pages/customers_page.dart';

void main() {
  // Initialize controllers
  Get.put(CartController(), permanent: true);
  Get.put(AuthController(), permanent: true); // AuthController globally
  Get.put(ThemeController(), permanent: true); // ThemeController globally

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      // Theme settings
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.light,

      // Start screen
      home: const SplashPage(),

      // Named routes
      getPages: [
        GetPage(name: '/categories', page: () => CategoriesPage()),
        GetPage(name: '/medicne', page: () => const OnboardingOne()),
        GetPage(name: '/vitamine', page: () => const OnboardingTwo()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/signup', page: () => const SignupPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/splash', page: () => const SplashPage()),
        GetPage(name: '/dashboard', page: () => DashboardPage()),
        GetPage(name: '/customers', page: () => CustomersPage()),
      ],
    );
  }
}
