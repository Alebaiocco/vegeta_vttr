// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vttr/components/top_bar.dart';
import 'package:vttr/models/product.dart';
import 'package:vttr/models/product_comment.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductComment> comments = [];
  double rating = 0;
  
  Future<void> getProductComment() async {
    try {
      comments = (await widget.product.comments)!;

      print("Quantidade de comentários do produto: " + comments.length.toString() + " " + widget.product.name);
    }
    catch(e) {
      print("Não foi possível buscar os comentários do produto.");
    }
  }
  
  @override
  void initState() {
    getProductComment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000915),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Cabeçalho
              const TopBar(
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
                    color: const Color(0xffA49930),
                    child: Column(
                      children: [
                        Image.network(
                          widget.product.product_image,
                          fit: BoxFit.fill,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            widget.product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 17,
                              fontFamily: 'Rubik',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 20, right: 20, top: 10), //ALTERAR
                          child: Text(
                            widget.product.description,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 13,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(
                          'RS ${widget.product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rubik',
                              color: Color(0xff000915)),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            // Implemente a lógica para adicionar o produto ao carrinho ou realizar a ação desejada
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2C5DA3),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(0, 30),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          child: Text("Saiba Mais", style: TextStyle(color: Color(0xffA2A2A4)),),
                        ),)
                      ],
                    ),
                  ),
                  // Comentarios
                  SizedBox(
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
                      Text(
                        '4.5',
                        style: TextStyle(
                          color: Color(0xffA49930),
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
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
