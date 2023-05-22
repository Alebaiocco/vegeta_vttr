// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:vttr/components/top_bar.dart';
import 'package:url_launcher/url_launcher.dart';
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

final Uri _url = Uri.parse('https://pub.dev/packages/url_launcher');

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({Key? key}) : super(key: key);

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
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
            TopBar(
              text: 'Meus Produtos', 
              text2: ''),           
            const Divider(
              thickness: 2,
              color: Color(0xffA49930),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            ElevatedButton(             
              onPressed: () {
                showConfirmationDialog(context);
              }, 
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2,
                    color: Color(0xffA49930),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor:  Color(0x00A49830),
                foregroundColor:  Color(0xffA49930),
              ),
              child: Text('Termos De Garantia'),
            ),
            ElevatedButton(             
              onPressed: _launchUrl,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2,
                    color: Color(0xffA49930),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor:  Color(0x00A49830),
                foregroundColor:  Color(0xffA49930),
              ),
              child: Text('Manual'),
            ),
            if (products.isNotEmpty)
              _buildProductList()
            else
              _buildEmptyProducts(),
          ],
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
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20),
              width: 288,
              height: 300,
              color: Color(0xffA49930),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      product.photoUrl,
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
                      product.description,
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
                      'N ${product.numSerie}',
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
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(35),
                      ),
                    ),
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: const EdgeInsets.only(left: 3),
                      child: Text(
                        product.garantia,
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
    );
  }

  Widget _buildEmptyProducts() {
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
        Text(
          'Nenhum produto encontrado',
          style: TextStyle(
            color: Color(0xffA49930),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  //Função para mostrar o texto de garantia ao usuário
  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Termo de Garantia'),
          content: Text('Aqui estão algumas informações importantes para ajudá-lo a entender melhor como a Garantia Shopee protege sua compra e como você pode solicitar o reembolso, caso haja algum contratempo com seu pedido. A Garantia Shopee assegura o recebimento e qualidade dos produtos que comprou, tornando mais fácil para você solicitar um reembolso em caso de inconvenientes. Esse processo certifica que o valor pago por você, em qualquer compra feita na nossa plataforma, seja creditado ao vendedor após 7 dias do recebimento do produto. É importante lembrar que para pedidos que ainda não foram encaminhados, os vendedores devem enviá-los dentro do período de Garantia Shopee. Caso contrário, o pagamento será automaticamente reembolsado a você após o término do prazo. Além disso, você pode usar uma extensão única de 3 dias da Garantia Shopee para um pedido que ainda não foi enviado. Para fazer isso, selecione Estender Garantia Shopee na página Detalhes do pedido.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Fecha a caixa de diálogo e retorna true
              },
              child: Text('Confirmar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Fecha a caixa de diálogo e retorna false
              },
              child: Text('Negar'),
            ),
          ],
        );
      },
    );
  }
}
