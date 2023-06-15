// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NewCommentsWidget extends StatelessWidget {
  //final String user;
  //final TextEditingController commentController;
  //final int assessment;

  //const NewCommentsWidget({
   // Key? key,
    //required this.user,
    //required this.commentController,
    //required this.assessment,
  //}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "NOME USUARIO",
                style: const TextStyle(
                  color: Color(0xffA2A2A4),
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              RatingBar.builder(
                initialRating: 3, // assessment
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 20,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (value) {
                  // Lógica para atualizar a avaliação
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Defina o valor de padding desejado
                child: TextField(
                  maxLines: null,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    color: Color(0xffA2A2A4),
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Digite seu comentário...',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
