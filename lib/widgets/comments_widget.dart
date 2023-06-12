import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentsWidget extends StatelessWidget {
  final String User;
  final String comment;
  final int assessment;

  const CommentsWidget({
    Key? key,
    required this.User,
    required this.comment,
    required this.assessment,
  }) : super(key: key);

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
                User,
                style: const TextStyle(
                  color: Color(0xffA2A2A4),
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              RatingBar.builder(
                initialRating: assessment.toDouble(),
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
            child: Text(
              comment,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Color(0xffA2A2A4),
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
