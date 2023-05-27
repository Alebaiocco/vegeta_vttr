// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, avoid_unnecessary_containers, use_key_in_widget_constructors, avoid_print, unused_local_variable, prefer_interpolation_to_compose_strings
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:vttr/screens/home_screen.dart';
import 'package:vttr/screens/signup_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

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

  Future<String> loginUser(String email, String password) async {
    var url = Uri.parse('http://ronaldo.gtasamp.com.br/api/user/login');

    try {
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(
              <String, String>{'email': email, 'password': password}));

      final responseBody = json.decode(response.body);
      final data = responseBody['data'];

      if (data['token'] != null) {
        final token = data['token'];

        print("Token = " + token);
        return token;
      }
    } catch (e) {
      //Renderizar uma mensagem na tela do usuário informando que o aplicativo está fora do ar
      print(e);
      return "";
    }

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000915),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/logo.png', width: 200, height: 200),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.93,
                  child: TextField(
                    controller: emailController,
                    style: TextStyle(color: Colors.white),
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
                padding: EdgeInsets.only(left: 10, top: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.93,
                  child: TextField(
                    controller: passwordController,
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
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
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: ElevatedButton(
                  onPressed: () {
                    //Colocar um sninner loading

                    String email = emailController.text;
                    String password = passwordController.text;
                    loginUser(email, password).then((value) => {
                          //Remover spinner loading
                          print(value),
                          if (value.isEmpty)
                            {
                              print("Usuário ou senha incorreto")
                              //Renderizar que usuário ou senha incorreto
                            }
                          else
                            {
                              //Salvar aqui o token (value) no AsyncStorage do aplicativo
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                              )
                            }
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffA49930),
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Entrar"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Signup()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0x00A49830),
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Cadastre-se"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
