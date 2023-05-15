// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyProducts extends StatefulWidget {
  const MyProducts({super.key});

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff000915),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Placeholder_logo_top
              Row(),
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
              Column(
                children: [
                  Text(
                    'Conheça Nossos Produtos',
                    style: TextStyle(color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      height: 200,
                      color: Color(0xffA49930),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/pedalUm.png',
                          ),

                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      height: 200,
                      color: Color(0xffA49930),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/pedalDois.png',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      height: 200,
                      color: Color(0xffA49930),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/pedalTres.png',
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
