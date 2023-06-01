// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_final_fields, library_private_types_in_public_api

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vttr/screens/login_screen.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite um e-mail válido';
    }
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Digite um e-mail válido';
    }
    return null;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite um username válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite uma senha válida';
    }
    if (value != _passwordController.text) {
      return 'As senhas não correspondem';
    }
    return null;
  }

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String email = "";
  String username = "";
  String password_1 = "";
  String password_2 = "";

  Future<List<String>> registerUser(
      String name, String mail, String pwd_1, String pwd_2) async {
    var url = Uri.parse('http://ronaldo.gtasamp.com.br/api/user/register');

    List<String> listaString = [];

    try {
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, String>{
            "name": name,
            "email": mail,
            "password": pwd_1,
            "password_confirmed": pwd_1
          }));

      if (response.statusCode == 201) {
        return [];
      } else {
        final data = json.decode(response.body);

        if (data['data']['message'] == null &&
            data['message']['erros'] != null) {
          List<String> erros = List<String>.from(
              data['message']['erros'].map((item) => item.toString()));

          if (erros.isNotEmpty) listaString.addAll(erros);
        }
      }

      return listaString;
    } catch (e) {
      //Renderizar uma mensagem na tela do usuário informando que o aplicativo está fora do ar
      listaString.add('Não foi possível realizar o cadastro');
      return listaString;
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
                      validator: _validateUsername,
                      onChanged: (value) => username = value,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Color(0xffA49930)),
                        labelText: 'Username',
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
                      validator: _validateEmail,
                      onChanged: (value) => email = value,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Color(0xffA49930)),
                        labelText: 'Email',
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
                      controller: _passwordController,
                      obscureText: true,
                      onChanged: (value) => password_1 = value,
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
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.93,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _confirmPasswordController,
                      obscureText: true,
                      validator: _validatePassword,
                      onChanged: (value) => password_2 = value,
                      decoration: InputDecoration(
                        hintText: '************',
                        labelText: 'Confirme sua Senha',
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
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        registerUser(username, email, password_1, password_2)
                            .then((errors) => {
                                  if (errors.isEmpty)
                                    {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Login()),
                                      )
                                    }
                                  else
                                    {
                                      for (var element in errors)
                                        {
                                          Text(element)
                                          //Rendererizar na tela uma mensagem do erro + element
                                        }
                                    }
                                });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 164, 152, 48),
                      foregroundColor: Colors.white,
                    ),
                    child: Text("Cadastrar"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff000915),
                      foregroundColor: Color.fromARGB(255, 164, 152, 48),
                    ),
                    child: Text("Voltar"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
