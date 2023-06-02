// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:vttr/screens/home_screen.dart';
import 'package:vttr/screens/login_screen.dart';
import 'package:vttr/screens/product_page.dart';
import 'package:vttr/screens/shop_screen.dart';
import 'package:vttr/screens/signup_screen.dart';
import 'package:vttr/screens/splash_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/my_products.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message);
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Adicione esta linha

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationSettings settings = await FirebaseMessaging.instance
      .requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true);

  final fcmToken = await FirebaseMessaging.instance.getToken();

  if (fcmToken != null) {
    await FirebaseMessaging.instance.subscribeToTopic("topic");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: Splash(),
    );
  }
}
