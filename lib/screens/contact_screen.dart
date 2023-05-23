// ignore_for_file: unused_import, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:vttr/components/top_bar.dart';
import 'dart:math';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  List<String> items = [
    'Selecione uma categoria',
    'Solicitação de Garantia',
    'Dúvidas',
    'Problemas com Funcionalidades',
    'Sugestão',
    'Outros'
  ];
  String? selectedItem = 'Selecione uma categoria';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000915),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Cabeçalho
              TopBar(
                  text: 'Fale Conosco',
                  text2: 'Tire suas dúvidas diretamente com o time da VTR'),
              Divider(
                thickness: 2,
                color: Color(0xffA49930),
              ),
              // Cabeçalho
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 40),
                    child: Text(
                      'Nome',
                      style: TextStyle(
                        color: Color(0xffA49930),
                        fontFamily: 'Roboto-bold',
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xffA49930)),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 15),
                    child: Text(
                      'Categorias',
                      style: TextStyle(
                        color: Color(0xffA49930),
                        fontFamily: 'Roboto-bold',
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xffA49930)),
                    ),
                  ),
                  value: selectedItem,
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                item,
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xffA2A2A4)),
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (item) => setState(() => selectedItem = item),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 15),
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                        color: Color(0xffA49930),
                        fontFamily: 'Roboto-bold',
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: TextField(
                  maxLines: 5,
                  minLines: 1,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xffA49930)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: Color(0xffA49930),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color(0x00A49830),
                    foregroundColor: Color(0xffA2A2A4),
                  ),
                  child: Text('Enviar'))
            ],
          ),
        ),
      ),
    );
  }
}
