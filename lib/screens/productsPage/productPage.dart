// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vttr/components/top_bar.dart';
import 'package:vttr/models/product.dart';
import 'package:vttr/models/product_comment.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vttr/widgets/comments_widget.dart';

import '../../repository/product.dart';

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

      print("Quantidade de comentários do produto: " +
          comments.length.toString() +
          " " +
          widget.product.name);

      setState(() {});
    } catch (e) {
      print("Não foi possível buscar os comentários do produto.");
    } finally {}
  }

  @override
  void initState() {
    getProductComment();
    super.initState();
  }

  final TextEditingController commentController = TextEditingController();
  late double assessment = 0.0;

  Widget mountBody() {
    return Column(
      children: comments
          .map<Widget>(
            (comment) => CommentsWidget(
                User: comment.User,
                comment: comment.comment,
                assessment: comment.assessment),
          )
          .toList(),
    );
  }

  void showNewComment() {
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
                'Novo Comentário',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: commentController,
                  decoration: InputDecoration(
                    labelText: 'Digite seu comentário...',
                    labelStyle: TextStyle(color: Color(0xffA49930)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffA49930), width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemSize: 20,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (value) {
                    assessment = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xffA49930),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop();

                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? token = prefs.getString('token');

                if (token == null) return;

                try {
                  await ProductRepositoryImpl().addProductComment(
                      token,
                      commentController.text,
                      assessment.toInt(),
                      widget.product.name);

                  Fluttertoast.showToast(
                    msg: 'Comentário adicionado com sucesso.',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 10,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    webShowClose: true,
                    webPosition: 'center',
                  );

                  await getProductComment();
                  
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Erro ao comentar:\n$error',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 7),
                      action: SnackBarAction(
                        label: 'OK',
                        textColor: Colors.white,
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );
                }
              },
              child: Text('Enviar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                              bottom: 15, left: 20, right: 20, top: 10),
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
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
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
                            child: Text(
                              "Saiba Mais",
                              style: TextStyle(color: Color(0xffA2A2A4)),
                            ),
                          ),
                        )
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Comentários',
                          style: TextStyle(
                            color: Color(0xffA2A2A4),
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              showNewComment();
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
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Color(0xff000915),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Color(0xffA49930),
                      ),
                    ),
                    child: Column(
                      children: [mountBody()],
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
