// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:vttr/components/top_bar.dart';

class ProdPage extends StatefulWidget {
  const ProdPage({super.key});

  @override
  State<ProdPage> createState() => _ProdPageState();
}

class _ProdPageState extends State<ProdPage> {
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
                  text: 'Produtos VTR',
                  text2: 'Explore nossa linha de produtos!'),
              Divider(
                thickness: 2,
                color: Color(0xffA49930),
              ),
              // Cabeçalho
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height:  MediaQuery.of(context).size.width * 1.10,
                    color: Color(0xffA49930),
                    child: Column(children: [
                      Image.asset('assets/images/pedalUm.png', fit: BoxFit.fill,),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      child: Text('ok'),
                      )
                    ]),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
