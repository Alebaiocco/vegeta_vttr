// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, avoid_unnecessary_containers, use_key_in_widget_constructors, avoid_print, unused_local_variable, prefer_interpolation_to_compose_strings, use_build_context_synchronously, prefer_final_fields, depend_on_referenced_packages
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:vttr/screens/home_screen.dart';
import 'package:vttr/screens/signup_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/global_data.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool isLoading = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite um e-mail válido';
    }
    final valueTrim = value.trim();
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegExp.hasMatch(valueTrim)) {
      return 'Digite um e-mail válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite uma senha válida';
    }
    return null;
  }

  Future<void> loginUser(String email, String password) async {
    var url = Uri.parse('https://ronaldo.gtasamp.com.br/api/user/login');

    List<String> listaString = [];

    setState(() {
      isLoading = true;
    });

    try {
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Access-Control-Allow-Credentials": 'true',
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST"
          },
          body: jsonEncode(
              <String, String>{'email': email, 'password': password}));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['data'] != null && data['data']['message'] != null) {
          String message = data['data']['message'];

          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 10,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            webShowClose: true,
            webPosition: 'center',
          );

          final token = data['data']['token'];
          // Armazenando o token no dispositivo do usuário
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);

          GlobalData().username = data['data']['user'];

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        }
      } else if (response.statusCode == 401) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['data']['message'] != null) {
          String errorMessage = data['data']['message'];

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                errorMessage,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 7),
              action: SnackBarAction(
                label: 'OK',
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        }
      } else if (response.statusCode >= 500) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['message'] != null && data['message']['erros'] != null) {
          List<String> erros = List<String>.from(
              data['message']['erros'].map((item) => item.toString()));

          if (erros.isNotEmpty) {
            listaString.addAll(erros);
          }

          String errorMessage = erros.join('\n');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Ops! Ocorreu um erro no login:\n$errorMessage',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 7),
              action: SnackBarAction(
                label: 'OK',
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        }
      } else if (response.statusCode == 401) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['data']['message'] != null) {
          String errorMessage = data['data']['message'];

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                errorMessage,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 7),
              action: SnackBarAction(
                label: 'OK',
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Ops! Ocorreu algum erro interno',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 7),
            action: SnackBarAction(
              label: 'OK',
              textColor: Colors.white,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000915),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/logo.png', width: 200, height: 200),
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.93,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      validator: _validateEmail,
                      onChanged: (value) => email = value,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Color(0xffA49930)),
                        labelText: 'Login',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Color(0xffA2A2A4)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.93,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      validator: _validatePassword,
                      obscureText: true,
                      onChanged: (value) => password = value,
                      decoration: InputDecoration(
                        hintText: '************',
                        labelText: 'Senha',
                        labelStyle: TextStyle(color: Color(0xffA49930)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Color(0xffA2A2A4)),
                        ),
                      ),
                    ),
                  ),
                ),
                if (isLoading)
                  Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: CircularProgressIndicator(
                      color: Color(0xffA49930),
                    ),
                  ),
                if (!isLoading)
                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginUser(email, password);
                          FocusScope.of(context).unfocus();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffA49930),
                        foregroundColor: Colors.white,
                      ),
                      child: Text("Entrar"),
                    ),
                  ),
                if (!isLoading)
                  Padding(
                      padding: EdgeInsets.only(left: 5, bottom: 5, top: 5),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Signup()),
                        ),
                        child: Text(
                          "Cadastre-se",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
