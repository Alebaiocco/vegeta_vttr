// ignore_for_file: prefer_const_constructors, unused_import, deprecated_member_use, prefer_const_declarations, use_build_context_synchronously, unused_local_variable, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, non_constant_identifier_names, unused_element, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vttr/components/top_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Product {
  final int serieNumber;
  final String name;
  final String garantia;
  final String photoUrl;
  final bool hasNewVersion;

  Product({
    required this.serieNumber,
    required this.name,
    required this.garantia,
    required this.photoUrl,
    this.hasNewVersion = false,
  });
}

final Uri _url = Uri.parse('https://pub.dev/packages/url_launcher');
final Uri _urlDriver = Uri.parse(
    'https://www.tuningparts.com.br/arq/manual-tecnico-de-instalacao-fastrev01web105211072019.pdf');
final Uri _urlGarantia = Uri.parse(
    'https://www.cianet.com.br/wp-content/uploads/2018/08/TERMO_DE_GARANTIA_-_Atualizado.pdf');

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({Key? key}) : super(key: key);

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  final List<Product> products = [];
  String messageEmptyProducts = '';

  @override
  void initState() {
    super.initState();
    listProduct().then((_) {
      setState(() {
        listProduct();
      });
    });
  }

  /*final List<Product> products = [
    Product(
      serieNumber: 08821,
      description: 'Descrição do produto 1',
      garantia: 'Vitalícia',
      photoUrl: 'assets/images/pedalUm.png',
      hasNewVersion: true,
    ),
    Product(
      serieNumber: 2034,
      description: 'Descrição do produto 2',
      garantia: '27/12/2024',
      photoUrl: 'assets/images/pedalDois.png',
    ),
    Product(
      serieNumber: 0900,
      description: 'Descrição do produto 3',
      garantia: '27/12/2024',
      photoUrl: 'assets/images/pedalTres.png',
    ),
  ];*/

  Future<void> listProduct() async {
    var url =
        Uri.parse('https://ronaldo.gtasamp.com.br/api/product/users/Product');

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
          "Access-Control-Allow-Credentials": 'true',
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST"
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['data'] != null && data['data']['product'] != null) {
          final List<dynamic> productData = data['data']['product'];

          products.clear();
          products.addAll(productData.map((data) {
            String garantia;
            if (data['resale'] == 1) {
              garantia = DateFormat('dd-MM-yyyy').format(
                  DateTime.parse(data['buy_date']).add(Duration(days: 365)));
            } else {
              garantia = 'Vitalícia';
            }
            return Product(
              serieNumber: data['serie_number'],
              photoUrl:
                  'https://ronaldo.gtasamp.com.br/' + data['product_image'],
              name: data['name'],
              garantia: garantia,
            );
          }));
        }
      } else if (response.statusCode >= 500) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['data'] != null && data['data']['message'] != null) {
          String message = data['data']['message'];
          messageEmptyProducts = message;
          print(messageEmptyProducts);
        }
      }
    } catch (e) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000915),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(text: 'Meus Produtos', text2: ''),
              const Divider(
                thickness: 2,
                color: Color(0xffA49930),
              ),
              ElevatedButton(
                onPressed: () {
                  transfeProduct(context);
                },
                child: Text('Transfer'),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              if (products.isNotEmpty)
                _buildProductList()
              else
                _buildEmptyProducts(messageEmptyProducts),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 288,
              height: 300,
              color: Color(0xff000915),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: GestureDetector(
                      onTap: () => {showManualOrDriver(context)},
                      child: SizedBox(
                        width: 288,
                        height: 300,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/logo.png',
                          image: product.photoUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.touch_app_outlined,
                    size: 30,
                    color: Color(0xffA49930),
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xff000915),
              width: 288,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    'Clique na imagem para verificar as atualizações ou o manual do produto',
                    style: TextStyle(
                      color: Color(0xffA49930),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 288,
              height: 55,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Color(0xffA49930),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 3),
                    alignment: Alignment.topLeft,
                    child: Text(
                      product.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 3),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'N° ${product.serieNumber}',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Rubik',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showConfirmationDialog(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 3),
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin: EdgeInsets.only(right: 150),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(35),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff000915),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            product.garantia,
                            style: TextStyle(
                              color: Color(0xffA49930),
                              fontFamily: 'Rubik',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyProducts(String message) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 100, left: 100, right: 100),
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/empityProducts.png',
            height: 200,
            width: 200,
          ),
        ),
        if (message != '')
          Text(
            message,
            style: TextStyle(
              color: Color(0xffA49930),
              fontWeight: FontWeight.bold,
            ),
          )
        else
          Text(
            'Ops, parece que você não possui produtos',
            style: TextStyle(
              color: Color(0xffA49930),
              fontWeight: FontWeight.bold,
            ),
          )
      ],
    );
  }

  //Função para mostrar o texto de garantia ao usuário
  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Termo de Garantia',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: Text(
              'Teve algum problema com seu produto? Clique no botão abaixo caso deseje "acionar a garantia" caso contrário, basta clicar em voltar para retornar a visualizar seus pedáis'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xffA49930),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Acionar Garantia'),
              onPressed: () {
                _launchGarantia();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Voltar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void transfeProduct(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog();
        });
  }

  void showManualOrDriver(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Explore mais seu produto',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: Text(
              'Opa, parece que você está interessado em saber mais sobre seu produto, não é mesmo? haha. Nos botões abaixo você tem acesso a área de manual do seu produto ou então se for um guitarrista veterano pode verifica a nova atualização de seu pedal.'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xffA49930),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Acessar o Manual'),
              onPressed: () {
                _launchManual();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xffA49930),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Baixar Nova Atualização'),
              onPressed: () {
                _launchDriver();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Voltar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchManual() async {
    if (!await launchUrl(_url)) {
      throw Exception('Não foi possivel acessar a página$_url');
    }
  }

  Future<void> _launchDriver() async {
    if (!await launchUrl(_urlDriver)) {
      throw Exception('Não foi possivel acessar a página $_urlDriver');
    }
  }

  Future<void> _launchGarantia() async {
    if (!await launchUrl(_urlGarantia)) {
      throw Exception('Não foi possivel acessar a página $_urlGarantia');
    }
  }
}
