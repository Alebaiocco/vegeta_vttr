// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vttr/widgets/top_bar.dart';
import 'package:vttr/models/product.dart';
import 'package:vttr/models/product_comment.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vttr/widgets/comments_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../repository/product.dart';
import '../widgets/nav_bar.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductComment> comments = [];
  double rating = 0;
  // ignore: non_constant_identifier_names
  double avg_assessment = 0.0;

  Future<void> getProductComment({reload = false}) async {
    try {
      if (!reload)
        comments = (await widget.product.comments)!;
      else {
        comments = (await widget.product.fetchComments())!;
      }

      await getProductAssessment();

      setState(() {});
    } catch (e) {
      print("Não foi possível buscar os comentários do produto.");
    } finally {}
  }

  Future<void> getProductAssessment() async {
    try {
      avg_assessment = (await ProductRepositoryImpl()
          .fetchProductAssessment(widget.product.id));

      print('avg_assessment é $avg_assessment');
    }
    // ignore: empty_catches
    catch (e) {}
  }

  @override
  void initState() {
    getProductComment();
    getProductAssessment();

    try {} catch (e) {
      avg_assessment = 0.0;
    }

    super.initState();

    final videoID = YoutubePlayer.convertUrlToId(widget.product.link_yt);

    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ));
  }

  final TextEditingController commentController = TextEditingController();
  late double assessment = 0.0;

  Widget mountBody() {
    print(comments.length);

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
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 167, 155, 48),
                          Color.fromARGB(255, 206, 192, 84),
                          Color.fromARGB(255, 255, 251, 179),
                        ],
                      ),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          color: Colors.white,
                          fit: BoxFit.cover,
                          height: 40,
                          width: 40,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Novo Comentário',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextFormField(
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
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 7),
                      child: Text("Avalie aqui ",
                          style: TextStyle(
                              color: Color(0xffA49930),
                              fontWeight: FontWeight.bold))),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: RatingBar.builder(
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
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: ElevatedButton(
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
                          )),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xffA49930),
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              Navigator.of(context).pop();

                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
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

                                await getProductComment(reload: true);
                              } catch (error) {
                                print("Falha ao comentar");

                                // ignore: use_build_context_synchronously
                                Fluttertoast.showToast(
                                  msg: error.toString().substring(10),
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 10,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  webShowClose: true,
                                  webPosition: 'center',
                                );
                              }
                            },
                            child: Text('Enviar'),
                          ))
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }


  //DIALOG PARA ALTERAR COMENTARIOS
  void alterComment() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 167, 155, 48),
                          Color.fromARGB(255, 206, 192, 84),
                          Color.fromARGB(255, 255, 251, 179),
                        ],
                      ),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          color: Colors.white,
                          fit: BoxFit.cover,
                          height: 40,
                          width: 40,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Alterar Comentario',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextFormField(
                      controller: commentController,
                      decoration: InputDecoration(
                        labelText: 'Altere seu comentário...',
                        labelStyle: TextStyle(color: Color(0xffA49930)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffA49930), width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 7),
                      child: Text("Avalie aqui ",
                          style: TextStyle(
                              color: Color(0xffA49930),
                              fontWeight: FontWeight.bold))),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: RatingBar.builder(
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
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: ElevatedButton(
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
                          )),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xffA49930),
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              Navigator.of(context).pop();

                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              String? token = prefs.getString('token');

                              if (token == null) return;

                              try {
                                await ProductRepositoryImpl().addProductComment(
                                    token,
                                    commentController.text,
                                    assessment.toInt(),
                                    widget.product.name);

                                Fluttertoast.showToast(
                                  msg: 'Comentário alterado com sucesso.',
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 10,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  webShowClose: true,
                                  webPosition: 'center',
                                );

                                await getProductComment(reload: true);
                              } catch (error) {
                                print("Falha ao alterar o comentário");

                                // ignore: use_build_context_synchronously
                                Fluttertoast.showToast(
                                  msg: error.toString().substring(10),
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 10,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  webShowClose: true,
                                  webPosition: 'center',
                                );
                              }
                            },
                            child: Text('Alterar'),
                          ))
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }
  late YoutubePlayerController _controller;
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
                        FadeInImage.assetNetwork(
                          placeholder: 'assets/images/logo.png',
                          image: widget.product.product_image,
                          fit: BoxFit.cover,
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
                          'RS ${widget.product.price}',
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
                                const url = 'https://vtreffects.com.br/loja/';
                                launch(url);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                onPrimary: Colors.black,
                                minimumSize: const Size(0, 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                shadowColor: Colors.black,
                                elevation: 10,
                              ),
                              child: Container(
                                width: 90,
                                child: Row(children: [
                                  Text(
                                    "Comprar",
                                    style: TextStyle(
                                      color: const Color(0xffA49930),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: SvgPicture.asset(
                                        "assets/images/cart.svg",
                                        color: Color(0xffA2A2A4),
                                        width: 16,
                                        height: 16),
                                  )
                                ]),
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffA49930), width: 3),
                    ),
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
                        avg_assessment == null
                            ? ('0.0')
                            : (avg_assessment.toString()),
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
