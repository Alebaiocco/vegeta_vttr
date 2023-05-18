// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names, override_on_non_overriding_member, annotate_overrides

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:vttr/screens/shop_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
    final CarouselImages = [
    'assets/images/pedalUm.png',
    'assets/images/pedalDois.png',
    'assets/images/pedalTres.png',
  ];

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff000915),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                // Cabeçalho
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
                // Cabeçalho
                Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10)),
                    //Carrossel de imagens
                    CarouselSlider.builder(
                    options: CarouselOptions(height: 400),
                    itemCount: CarouselImages.length,
                    itemBuilder: (context, index, realIndex) {
                      final carrossel = CarouselImages[index];
                      
                      return buildImage(carrossel, index);
                    },
                    ),
                    Padding(padding: EdgeInsets.only(top : 10)),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ShopPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                            width: 2,
                            color: Color(0xffA49930),
                            ),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        backgroundColor: Color(0x00A49830),
                        foregroundColor: Color(0xffA2A2A4),
                      ),
                      child: Text("Saiba Mais"),
                    ),
                    Padding(padding: EdgeInsets.only(top : 20)),
                    Image.asset('assets/images/equipe.jpeg',
                        width: MediaQuery.of(context).size.width * 0.8),
                    Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 20),
                      child: Text(
                        'Quem Somos',
                        style: TextStyle(color: Color(0xffA2A2A4)),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Padding(
                          padding: EdgeInsets.only(left: 40, right: 40),
                          child: Text(
                            '  O ano era 2015 e nosso fundador Ítalo se encontrava insatisfeito com sua pedaleira Zoom G1. Sonhava em desbravar o mundo dos efeitos, mas não tinha recursos financeiros para investir em um setup de pedais ou mesmo em uma nova pedaleira. Contudo, a limitação financeira não foi um empecilho para ele. Pelo contrário, diante deste cenário encontrou o ambiente perfeito para a idealização de um pedal, que de forma despretensiosa se tornaria o sonho chamado VTR EFFECTS.',
                            style: TextStyle(color: Color(0xffA2A2A4)),
                            textAlign: TextAlign.justify,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildImage(String CarouselImages, int index) => Container(
    margin: EdgeInsets.symmetric(horizontal: 12),
    color: Colors.grey,
    child: Image.asset(
      CarouselImages,
      fit: BoxFit.cover,
    ),
  );
}
