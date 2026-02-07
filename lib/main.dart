import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/pages/confirmed_orders_page.dart';

import 'controllers/cart_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/theme_controller.dart';
import 'controllers/categories_controller.dart';

import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/splash.dart';
import 'pages/categories_page.dart';
import 'screens/medicne.dart';
import 'screens/vitamine.dart';
import 'screens/home.dart';
import 'pages/dashboard_page.dart';
import 'pages/customers_page.dart';
<<<<<<< HEAD
feature/SCRUM-19-admin
// import 'pages/order_details_page.dart'; 
  // Added this since you reference it
 main
=======

import 'pages/profile.dart';
// import other pages you already have:
// import 'pages/categories_page.dart';
// import 'pages/confirmed_orders_page.dart';
// import 'pages/messages_page.dart';
// import 'pages/login_page.dart';
>>>>>>> 5b7fae6 (SCRUM-17)

void main() {
  // Initialize controllers globally
  Get.put(CartController(), permanent: true);
  Get.put(AuthController(), permanent: true);
  Get.put(ThemeController(), permanent: true);
  Get.put(CategoriesController(), permanent: true);

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
      themeMode: ThemeMode.light, // Can later be dynamic via ThemeController
      // Start screen
      home: const SplashPage(),

      // Named routes
      getPages: [
<<<<<<< HEAD
        GetPage(name: '/splash', page: () => const SplashPage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/signup', page: () => const SignupPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/medicne', page: () => const OnboardingOne()),
        GetPage(name: '/vitamine', page: () => const OnboardingTwo()),
        GetPage(name: '/dashboard', page: () => DashboardPage()),
        GetPage(name: '/customers', page: () => CustomersPage()),
        GetPage(name: '/categories', page: () => CategoriesPage()),
 feature/SCRUM-19-admin
        GetPage(name: '/order_details', page: () => const OrderDetailsPage()),
        // GetPage(name: '/order_details', page: () => const OrderDetailsPage()),
        main
        GetPage(name: '/confirmed_orders', page: () => OrderDetailsPage()),
=======
        GetPage(name: "/dashboard", page: () => DashboardPage()),
        GetPage(name: "/customers", page: () => CustomersPage()),

         GetPage(
        name: "/profile",
        page: () => const ProfileScreen(),
        ),

        // Add your real pages here:
        // GetPage(name: "/categories", page: () => CategoriesPage()),
        // GetPage(name: "/order_details", page: () => ConfirmedOrdersPage()),
        // GetPage(name: "/messages", page: () => MessagesPage()),
        // GetPage(name: "/login", page: () => LoginPage()),
>>>>>>> 5b7fae6 (SCRUM-17)
      ],
      
    );
  }
}
