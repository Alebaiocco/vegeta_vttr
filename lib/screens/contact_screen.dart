// ignore_for_file: unused_import, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'dart:math';


class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];
  String? selectedItem = 'Item 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000915),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            Image.asset(
              'assets/images/logo.png',
              height: 50,
              width: 50,
            ),
            Divider(
              thickness: 2,
              color: Color(0xffA49930),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 40),
                  child: Text(
                    'Nome',
                    style: TextStyle(
                      color: Color(0xffA49930),
                      fontFamily: 'Roboto-bold', fontSize: 18,
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
              style: TextStyle(color: Colors.white ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical:  2),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Color(0xffA49930)),
                ),
              ),
            ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    'Categorias',
                    style: TextStyle(
                      color: Color(0xffA49930),
                      fontFamily: 'Roboto-bold', fontSize: 18,
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
                contentPadding: EdgeInsets.symmetric(vertical:  2),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Color(0xffA49930)),
                ),
              ),
                value: selectedItem,
                items: items.map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(item, style: TextStyle(fontSize: 20 ,color: Color(0xffA2A2A4)),),
                  ),
                )).toList(),
                onChanged: (item)=> setState(() => selectedItem = item),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Descrição',
                    style: TextStyle(
                      color: Color(0xffA49930),
                      fontFamily: 'Roboto-bold', fontSize: 18,
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
              style: TextStyle(color: Colors.white ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical:  2),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Color(0xffA49930)),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: (){}, 
            child: Text('Enviar', style: TextStyle(color: Colors.white),))
          ],
        ),
      ),
    );
  }
}
