import 'package:flutter/material.dart';
import 'package:rod_erp/google_sheets_api.dart';
import 'package:rod_erp/home_page.dart';
import 'package:rod_erp/main_page.dart';
import 'package:rod_erp/my_orders.dart';
import 'package:rod_erp/orders_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleSheetsAPI().init();
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.grey[900]),

    initialRoute: '/',
    routes: {
      '/': (context) => const HomePage(),
      '/mainPage': (context) => const MainPage(),
      '/orders': (context) => const OrdersPage(),
      '/my_orders': (context) => const MyOrders(),
    },

  ));
}


