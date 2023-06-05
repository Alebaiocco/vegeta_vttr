// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, file_names

import 'package:flutter/material.dart';
import 'package:vttr/components/top_bar.dart';


class PedalUmPage extends StatefulWidget {
  const PedalUmPage({super.key});

  @override
  State<PedalUmPage> createState() => _PedalUmPageState();
}

class _PedalUmPageState extends State<PedalUmPage> {
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
                    height:  MediaQuery.of(context).size.width * 1.15,
                    color: Color(0xffA49930),
                    child: Column(children: [
                      Image.asset('assets/images/pedalUm.png', fit: BoxFit.fill,),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                      child: Text('Narciso Delay',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                        fontFamily: 'Rubik',
                        ),
                      ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      child: Text('Um delay stereo de alta qualidade com uma ampla gama de opções de personalização para dar ao seu som a ambiência perfeita. Com quatros modos de delays diferentes, você pode escolher desde um clássico delay analógico até um delay com pitch bem psicodélico.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w400
                      ),
                      )
                      )
                    ]),
                  ),
                SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('RS 999,99',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Rubik',
                      color: Color(0xffA2A2A4)
                    ),),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2C5DA3),
                        foregroundColor: Colors.white,
                        minimumSize: Size(0, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      child: Text("Comprar"),
                    ),
                  ],
                ),
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