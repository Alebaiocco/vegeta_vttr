// ignore_for_file: non_constant_identifier_names, deprecated_member_use, use_build_context_synchronously
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:vttr/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vttr/screens/login_screen.dart';

class TopBar extends StatelessWidget {
  final String text, text2;

  const TopBar({super.key, required this.text, required this.text2});

  void confirmationLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning,
                  size: 60,
                  color: Colors.red,
                ),
                SizedBox(height: 16),
                Text(
                  'Deseja Sair?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Sim',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () async {
                          // Remover o token do SharedPreferences
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.remove('token');

                          // Navegar para a tela de login
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Não',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if ((text2 != '') && (text != '')) {
      return Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
              child: Image.asset(
                'assets/images/logo.png',
                height: 50,
                width: 50,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              confirmationLogout(context);
            },
            icon: Icon(Icons.exit_to_app_outlined),
            color: Color(0xffA49930),
          ),
        ],
      );
    } else if ((text2 == '') && (text != '')) {
      return Row(
        children: [
          Container(
              margin: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()))
                },
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 50,
                  width: 50,
                ),
              )),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xffA49930),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              confirmationLogout(context);
            },
            icon: Icon(Icons.exit_to_app_outlined),
            color: Color(0xffA49930),
          ),
        ],
      );
    } else {
      return Padding(
          padding: EdgeInsets.only(top: 50),
          child: Image.asset(
            'assets/images/logo.png',
            height: 50,
            width: 50,
          ));
    }
  }
}
