// ignore_for_file: unused_import, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, avoid_web_libraries_in_flutter, use_build_context_synchronously, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vttr/widgets/top_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:vttr/screens/home_screen.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  String description = "";
  List<String> items = [
    'Selecione uma categoria',
    'Solicitação de Garantia',
    'Dúvidas',
    'Problemas com funcionalidades',
    'Sugestão',
    'Outros'
  ];
  String? selectedItem = 'Selecione uma categoria';
  bool isLoading = false;

  Future<void> pushContact() async {
    var url =
        Uri.parse('https://ronaldo.gtasamp.com.br/api/contact/send-contact');
    List<String> listaString = [];
    setState(() {
      isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
            "Access-Control-Allow-Credentials": 'true',
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST"
          },
          body: jsonEncode(<String, String>{
            'category': selectedItem ?? '',
            'description': description
          }));

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
                'Ops! Ocorreu um erro no envio da mensagem:\n$errorMessage',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Cabeçalho
              TopBar(
                text: 'Fale Conosco',
                text2: 'Tire suas dúvidas diretamente com o time da VTR',
              ),
              Divider(
                thickness: 2,
                color: Color(0xffA49930),
              ),
              Padding(
                padding: EdgeInsets.only(top: 80, left: 10, right: 10),
                child: Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: Color.fromARGB(255, 66, 66, 83).withOpacity(0.3),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  fit: BoxFit.cover,
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Fale Conosco',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xffA49930),
                                  fontFamily: 'Roboto-bold',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    'Categorias',
                                    style: TextStyle(
                                      color: Color(0xffA49930),
                                      fontFamily: 'Roboto-bold',
                                      fontSize: 18,
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color(0xffA49930),
                                  ),
                                ),
                              ),
                              value: selectedItem,
                              items: items.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xffA2A2A4),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (item) {
                                setState(() {
                                  selectedItem = item;
                                });
                              },
                              dropdownColor: Color(0xff000915),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    'Descrição',
                                    style: TextStyle(
                                      color: Color(0xffA49930),
                                      fontFamily: 'Roboto-bold',
                                      fontSize: 18,
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: TextFormField(
                              onChanged: (value) => description = value,
                              maxLines: 5,
                              minLines: 1,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color(0xffA49930),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          if (!isLoading)
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  pushContact();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 2,
                                      color: Color(0xff777D6D),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  primary: Color(0xffA49930),
                                  onPrimary: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                ),
                                child: Text('Enviar'),
                              ),
                            ),
                          if (isLoading)
                            Center(
                              child: CircularProgressIndicator(
                                color: Color(0xffA49930),
                              ),
                            ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 30),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        const url =
                                            'https://www.instagram.com/vtreffects/';
                                        launch(url);
                                      },
                                      child: SvgPicture.asset(
                                          "assets/images/insta.svg"),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        const url = 'https://vtreffects.com.br';
                                        launch(url);
                                      },
                                      child: SvgPicture.asset(
                                          "assets/images/site.svg"),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        const url =
                                            'https://api.whatsapp.com/send/?phone=5527998660610&text&type=phone_number&app_absent=0';
                                        launch(url);
                                      },
                                      child: SvgPicture.asset(
                                          "assets/images/whats.svg"),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
