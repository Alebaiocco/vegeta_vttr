// ignore_for_file: unused_import, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];
  String? selectedItem = 'item 1';

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
            Text(
              'Nome',
              style: TextStyle(
                color: Color(0xffA49930),
                fontFamily: 'Rubik',
              ),
            ),
            DropdownButton<String>(
              value: selectedItem,
              items: items.
                map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: TextStyle(fontSize: 24)),
                 )).toList(),
                 onChanged: (item) => setState(()=> selectedItem = item),
           )
          ],
        ),
      ),
    );
  }
}
