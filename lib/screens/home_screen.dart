// ignore_for_file: non_constant_identifier_names
// ignore_for_file: prefer_const_constructors
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:vttr/screens/contact_screen.dart';
import 'package:vttr/screens/my_products.dart';
import 'package:vttr/screens/shop_screen.dart';
import 'package:vttr/components/nav_bar.dart';
import 'package:vttr/components/top_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CarouselImages = [
    'assets/images/pedalUm.png',
    'assets/images/pedalDois.png',
    'assets/images/pedalTres.png',
  ];

  final List<Widget> pages = [
    const Home(),
    const ShopPage(),
    const MyProductsPage(),
    const Contact(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000915),
      bottomNavigationBar: NavBar(
        selectedIndex: _selectedIndex,
        onTabChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // Cabeçalho
                  TopBar(
                      text: 'Olá, Username!', text2: 'Bem vindo a VTR Effects'),
                  const Divider(
                    thickness: 2,
                    color: Color(0xffA49930),
                  ),
                  // Cabeçalho
                  Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      // Carrossel de imagens
                      GestureDetector(
                        onDoubleTap: ()=>{
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  ShopPage()))
                        },
                        child: CarouselSlider.builder(
                        options: CarouselOptions(height: 400),
                        itemCount: CarouselImages.length,
                        itemBuilder: (context, index, realIndex) {
                          final carrossel = CarouselImages[index];

                          return buildImage(carrossel, index);
                        },
                      )),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 1; // Navega para a página ShopPage
                          });
                        },
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
                        child: const Text("Saiba Mais"),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      Image.asset(
                        'assets/images/equipe.jpeg',
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
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
                        ),
                      ),
                      SizedBox(
                      height: 20,
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
                              'assets/images/artistas.png',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.49,
                              height: 200,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 55),
                              child: Text('Artistas',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 17,
                                fontFamily: 'Rubik',
                                ),), 
                            ),
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
            const ShopPage(),
            const MyProductsPage(),
            const Contact(),
          ],
        ),
      ),
    );
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
