// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000915),
      body: Container(
        child: Column(
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
            Column(
              children: [
                Image.asset('assets/images/equipe.jpeg', width:MediaQuery.of(context).size.width * 0.8 ),
                Padding(padding: EdgeInsets.only(top: 30, bottom: 20),
                child: Text('Quem Somos', style: TextStyle(color: Colors.white),),
                ),
                Padding(padding: EdgeInsets.only(top: 6),
                child: Padding(padding: EdgeInsets.only(left: 40, right: 40),
                  child:Text('  O ano era 2015 e nosso fundador Ítalo se encontrava insatisfeito com sua pedaleira Zoom G1. Sonhava em desbravar o mundo dos efeitos, mas não tinha recursos financeiros para investir em um setup de pedais ou mesmo em uma nova pedaleira. Contudo, a limitação financeira não foi um empecilho para ele. Pelo contrário, diante deste cenário encontrou o ambiente perfeito para a idealização de um pedal, que de forma despretensiosa se tornaria o sonho chamado VTR EFFECTS.',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.justify,
                    ),
                  )
                ),
              ],
            ),
            // Row(
            //   children: [
            //     Container(
            //       width: MediaQuery.of(context).size.width * 0.5,
            //       height: 200,
            //       color:Color(0xffA49930) ,
            //     ),
            //   ],
            //)
          ],
        ),
      ),
    );
  }
}
