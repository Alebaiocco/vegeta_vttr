// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:vttr/screens/home_screen.dart';
import 'package:vttr/screens/login_screen.dart';
import 'package:vttr/screens/shop_screen.dart';
import 'package:vttr/screens/signup_screen.dart';
import 'package:vttr/screens/splash_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/my_products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: Splash(),
    );
  }
}