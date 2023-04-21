// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000915),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/logo.png', width: 200 , height: 200),
            Padding(padding: EdgeInsets.only(left: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: TextField(
                style: TextStyle(color: Colors.white ),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Color(0xffA49930)),
                  labelText: 'Login',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xffA2A2A4)),
                  ),
                ),
              ),
            ),),
            Padding(padding: EdgeInsets.only(left: 10,top: 30),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: TextField(
                style: TextStyle(color: Colors.white ),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '************',
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: Color(0xffA49930)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xffA2A2A4)),
                  ),
                ),
              ),
            ),),
          
            ],
        ),
      ),
    );
  }
}
