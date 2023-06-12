// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vttr/components/top_bar.dart';

class PedalUmPage extends StatefulWidget {
  const PedalUmPage({Key? key}) : super(key: key);

  @override
  _PedalUmPageState createState() => _PedalUmPageState();
}

class _PedalUmPageState extends State<PedalUmPage> {
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000915),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Cabeçalho
              TopBar(
                text: 'Produtos VTR',
                text2: 'Explore nossa linha de produtos!',
              ),
              const Divider(
                thickness: 2,
                color: Color(0xffA49930),
              ),
              // Cabeçalho
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.width * 1.15,
                    color: Color(0xffA49930),
                    child: Column(children: [
                      Image.asset(
                        'assets/images/pedalUm.png',
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          'Narciso Delay',
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 17,
                            fontFamily: 'Rubik',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        child: Text(
                          'Um delay stereo de alta qualidade com uma ampla gama de opções de personalização para dar ao seu som a ambiência perfeita. Com quatros modos de delays diferentes, você pode escolher desde um clássico delay analógico até um delay com pitch bem psicodélico.',
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 11,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ]),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'RS 999,99',
                          style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Rubik',
                              color: Color(0xffA2A2A4)),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2C5DA3),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(0, 30),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          child: const Text("Comprar"),
                        ),
                      ],
                    ),
                  ),
                  // Comentarios Pedal 1
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 5),
                        child: SvgPicture.asset(
                          'assets/images/star.svg',
                          width: 22,
                          height: 22,
                        ),
                      ),
                      Container(
                        child: const Text(
                          '4.5',
                          style: TextStyle(
                            color: Color(0xffA49930),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Comentários', 
                        style: TextStyle(
                          color: Color(0xffA2A2A4),
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // COMEÇAR A COMENTAR
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: Color(0xffA49930),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color(0xff000915),
                          foregroundColor: Color(0xffA2A2A4),
                        ),
                        child: Text('Comentar'))
                    ],
                  ),),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color:  Color(0xff000915),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color:  Color(0xffA49930),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Username", // mome do usuario
                                style: TextStyle(
                                  color: Color(0xffA2A2A4), 
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17
                                  ),
                              ), 
                              RatingBar.builder(
                                initialRating: rating,
                                minRating: 1,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 20,
                                itemBuilder: (context, _) =>Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (value) {
                                  setState(() {
                                    rating = value;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Color(0xffA2A2A4),
                              fontSize: 14
                            ),
                          ),
                        ),)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
