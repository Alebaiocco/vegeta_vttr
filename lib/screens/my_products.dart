// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Product {
  final int numSerie;
  final String description;
  final String garantia;
  final String photoUrl;

  Product({
    required this.numSerie,
    required this.description,
    required this.garantia,
    required this.photoUrl,
  });
}

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({super.key});

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  final List<Product> products = [
    Product(
      numSerie: 08821,
      description: 'Descrição do produto 1',
      garantia: 'Vitalícia',
      photoUrl: 'assets/images/pedalUm.png',
    ),
    Product(
      numSerie: 2034,
      description: 'Descrição do produto 2',
      garantia: '27/12/2024',
      photoUrl: 'assets/images/pedalDois.png',
    ),
    Product(
      numSerie: 0900,
      description: 'Descrição do produto 3',
      garantia: '27/12/2024',
      photoUrl: 'assets/images/pedalTres.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000915),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 50,
                      width: 50,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Meus Produtos',
                      style: TextStyle(
                        color: Color(0xffA49930),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
              color: Color(0xffA49930),
            ),
            if (products.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 20),
                        width: 288,
                        height: 300,
                        color: Color(0xffA49930),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.asset(
                                products[index].photoUrl,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 288,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Color(0xffA49930),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(35),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 3),
                              alignment: Alignment.topLeft,
                              child: Text(
                                products[index].description,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 3),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'N ${products[index].numSerie}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Rubik',
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 2,
                                bottom: 2,
                                left: 3,
                                right: 180,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(35),
                                ),
                              ),
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                margin: EdgeInsets.only(left: 3),
                                child: Text(
                                  products[index].garantia,
                                  style: TextStyle(
                                    color: Color(0xffA49930),
                                    fontFamily: 'Rubik',
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
              )
            else
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top:100, left: 100, right: 100),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/empityProducts.png',
                      height: 200,
                      width: 200,
                    ),
                  ),
                  Text(
                    'Nenhum produto encontrado',
                    style: TextStyle(
                      color: Color(0xffA49930),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
