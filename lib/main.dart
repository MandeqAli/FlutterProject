import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/cart_controller.dart';
import 'controllers/theme_controller.dart';

import 'pages/dashboard_page.dart';
import 'pages/customers_page.dart';
// import other pages you already have:
// import 'pages/categories_page.dart';
// import 'pages/confirmed_orders_page.dart';
// import 'pages/messages_page.dart';
// import 'pages/login_page.dart';

void main() {
  Get.put(CartController(), permanent: true);
  Get.put(ThemeController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.light,

      initialRoute: "/dashboard",
      getPages: [
        GetPage(name: "/dashboard", page: () => DashboardPage()),
        GetPage(name: "/customers", page: () => CustomersPage()),
        // Add your real pages here:
        // GetPage(name: "/categories", page: () => CategoriesPage()),
        // GetPage(name: "/order_details", page: () => ConfirmedOrdersPage()),
        // GetPage(name: "/messages", page: () => MessagesPage()),
        // GetPage(name: "/login", page: () => LoginPage()),
      ],
    );
  }
}
