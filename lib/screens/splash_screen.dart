// ignore_for_file: unused_import, prefer_const_constructors, use_build_context_synchronously, avoid_unnecessary_containers, unused_element

import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'home_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    //_navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(seconds: 4), () {});
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => MyHomePage(title: 'Home')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.png'),
            SvgPicture.asset('images/logo.svg'),
            SizedBox(height: 16),
            Text(
              'Bem-vindo ao meu aplicativo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
