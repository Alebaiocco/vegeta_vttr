// ignore_for_file: non_constant_identifier_names
// ignore_for_file: prefer_const_constructors
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vttr/screens/contact_screen.dart';
import 'package:vttr/screens/my_products.dart';
import 'package:vttr/screens/shop_screen.dart';
import 'package:vttr/widgets/nav_bar.dart';
import 'package:vttr/widgets/top_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/global_data.dart';

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

  GlobalData globalData = GlobalData();

  int _selectedIndex = 0;

  final youtubeUrl = "https://www.youtube.com/watch?v=shH6FgfZQUM";

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoID = YoutubePlayer.convertUrlToId(youtubeUrl);

    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ));
  }

  @override
  Widget build(BuildContext context) {
    String username = globalData.getUsername();
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
                      text: 'Olá $username', text2: 'Bem vindo a VTR Effects'),
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
                      Padding(
                        padding: EdgeInsets.only( bottom: 20),
                        child: Text(
                          'Quem Somos',
                          style: TextStyle(
                            color: Color(0xffA2A2A4),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: YoutubePlayer(
                          controller: _controller,
                          showVideoProgressIndicator: true,
                          onReady: () => debugPrint('Ready'),
                          bottomActions: [
                            CurrentPosition(),
                            ProgressBar(
                              isExpanded: true,
                              colors: const ProgressBarColors(
                                playedColor: Color(0xffA49930),
                                handleColor: Color(0xffA49930),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:15),
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
                                  bottomLeft: Radius.circular(5.0),
                                ),
                                child: Image.asset(
                                  'assets/images/artistas.png',
                                  fit: BoxFit.cover,
                                  width:
                                      MediaQuery.of(context).size.width * 0.49,
                                  height: 200,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 55),
                                child: Text(
                                  'Artistas',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                    fontFamily: 'Rubik',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    const url =
                                        'https://www.instagram.com/vtreffects/';
                                    launch(url);
                                  },
                                  child: SvgPicture.asset(
                                      "assets/images/insta.svg"),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    const url = 'https://vtreffects.com.br';
                                    launch(url);
                                  },
                                  child: SvgPicture.asset(
                                      "assets/images/site.svg"),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    const url =
                                        'https://api.whatsapp.com/send/?phone=5527998660610&text&type=phone_number&app_absent=0';
                                    launch(url);
                                  },
                                  child: SvgPicture.asset(
                                      "assets/images/whats.svg"),
                                ),
                              ],
                            ),
                          ))
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
