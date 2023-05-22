// ignore_for_file: non_constant_identifier_names, deprecated_member_use
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String text, text2;

  const TopBar({super.key, required this.text, required this.text2});

  @override
  Widget build(BuildContext context) {
    if (text2 != '') {
      return Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Image.asset(
              'assets/images/logo.png',
              height: 50,
              width: 50,
            ),
          ),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                text,
                style: TextStyle(
                  color: Color(0xffA49930),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                text2,
                style: TextStyle(
                  color: Color(0xffA49930),
                ),
              ),
            ]),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Image.asset(
              'assets/images/logo.png',
              height: 50,
              width: 50,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xffA49930),
                fontWeight: FontWeight.bold,
              ), 
            ),              
          ),
        ],
      );
    }
  }
}
