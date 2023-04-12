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
      backgroundColor: Color(0xff00000),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/jhonMayer.png'),
            fit: BoxFit.cover,
            opacity: 0.40
              )
            ),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'E-mail',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
              obscureText: true,
            ),
            /*  RaisedButton(
              child: Text('Entrar'),
              onPressed: () {
                // Adicione aqui a lógica de validação do formulário
                if (true) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro de validação'),
                    ),
                  );
                }
              },
            ), */
          ],
        ),
      ),
    );
  }
}
