// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/categories_page.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pharmacy App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.orange,
      ),

      // ✅ start page
      home: CategoriesPage(),

      // ✅ optional routes (recommended)
      getPages: [
        GetPage(name: '/', page: () => CategoriesPage()),
        GetPage(name: '/cart', page: () => const CartScreen()),
      ],
    );
  }
}
