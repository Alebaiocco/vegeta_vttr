import 'package:flutter/material.dart';
import 'package:vttr/models/product.dart';
import 'package:vttr/screens/productsPage/productPage.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xffA49930),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
              ),
              child: Image.network(
                product.product_image,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.45,
                height: 200,
              ),
            ),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 15),
                    child: Text(
                      product.name.toString(),
                      style: const TextStyle(
                        fontSize: 17,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9),
                    child: SingleChildScrollView(
                      child: Text(
                        "${product.description.substring(0, 248)}...",
                        style: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(product: product),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 2,
                          color: Color(0xff2C5DA3),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(20, 20),
                      backgroundColor: const Color(0xff2C5DA3),
                      foregroundColor: const Color(0xffA2A2A4),
                    ),
                    child: const Text(
                      'Saiba Mais',
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
