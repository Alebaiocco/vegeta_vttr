// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:vttr/components/top_bar.dart';
import 'package:vttr/screens/productsPage/pedalDois_page.dart';
import 'package:vttr/screens/productsPage/pedalUm_page.dart';

import 'productsPage/pedalTres_page.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
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
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xffA49930),
                        ),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 200,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0),),
                            child: Image.asset(
                              'assets/images/pedalUm.png',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 200,
                              ),
                            ),
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Padding(padding: EdgeInsets.only(top: 10, bottom: 15),
                                  child: Text('Narciso Delay',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.bold
                                  ),
                                  )),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 9),
                                  child: Text('Um delay stereo de alta qualidade com uma ampla gama de opções de personalização para dar ao seu som a ambiência perfeita. Com quatros modos de delays diferentes, você pode escolher desde um clássico delay analógico até um delay com pitch bem psicodélico.', 
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w400
                                  ),
                                  textAlign: TextAlign.justify,
                                )),
                                SizedBox(height: 10,),
                                ElevatedButton(
                                  onPressed:  () => {
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  PedalUmPage()))
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 2,
                                        color: Color(0xff2C5DA3),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    minimumSize: Size(20, 20),
                                    backgroundColor: Color(0xff2C5DA3),
                                    foregroundColor: Color(0xffA2A2A4),
                                  ),
                                  child: Text(
                                    'Saiba Mais',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ]),
                            )
                          ],
                        ),
                      ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xffA49930),
                        ),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 200,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0),),
                            child: Image.asset(
                              'assets/images/pedalDois.png',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 200,
                              ),
                            ),
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Padding(padding: EdgeInsets.only(top: 10, bottom: 15),
                                  child: Text('Helios Overdrive',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.bold
                                  ),
                                  )),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 9),
                                  child: Text('Um delay stereo de alta qualidade com uma ampla gama de opções de personalização para dar ao seu som a ambiência perfeita. Com quatros modos de delays diferentes, você pode escolher desde um clássico delay analógico até um delay com pitch bem psicodélico.', 
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w400
                                  ),
                                  textAlign: TextAlign.justify,
                                )),
                                SizedBox(height: 10,),
                                ElevatedButton(
                                  onPressed:  () => {
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  PedalDoisPage()))
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 2,
                                        color: Color(0xff2C5DA3),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    minimumSize: Size(20, 20),
                                    backgroundColor: Color(0xff2C5DA3),
                                    foregroundColor: Color(0xffA2A2A4),
                                  ),
                                  child: Text(
                                    'Saiba Mais',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ]),
                            )
                          ],
                        ),
                      ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xffA49930),
                        ),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 200,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0),),
                            child: Image.asset(
                              'assets/images/pedalTres.png',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 200,
                              ),
                            ),
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Padding(padding: EdgeInsets.only(top: 10, bottom: 15),
                                  child: Text('Kailani Reverb',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.bold
                                  ),
                                  )),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 9),
                                  child: Text('Um delay stereo de alta qualidade com uma ampla gama de opções de personalização para dar ao seu som a ambiência perfeita. Com quatros modos de delays diferentes, você pode escolher desde um clássico delay analógico até um delay com pitch bem psicodélico.', 
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w400
                                  ),
                                  textAlign: TextAlign.justify,
                                )),
                                SizedBox(height: 10,),
                                ElevatedButton(
                                  onPressed:  () => {
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  PedalTresPage()))
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 2,
                                        color: Color(0xff2C5DA3),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    minimumSize: Size(20, 20),
                                    backgroundColor: Color(0xff2C5DA3),
                                    foregroundColor: Color(0xffA2A2A4),
                                  ),
                                  child: Text(
                                    'Saiba Mais',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ]),
                            )
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 40,
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
