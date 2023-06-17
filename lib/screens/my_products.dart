// ignore_for_file: prefer_const_constructors, unused_import, deprecated_member_use, prefer_const_declarations, use_build_context_synchronously, unused_local_variable, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, non_constant_identifier_names, unused_element, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vttr/components/top_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:vttr/screens/home_screen.dart';

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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    listProduct().then((_) {
      setState(() {
        listProduct();
      });
    });
  }

  String? _validateEmailTransferencia(String? value) {
    print(value);
    if (value == null || value.isEmpty) {
      return 'Digite um e-mail válido';
    }
    final valueTrim = value.trim();
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegExp.hasMatch(valueTrim)) {
      return 'Digite um e-mail válido';
    }
    return null;
  }

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

  Future<void> transfeProduct(String newUser, String name) async {
    var url = Uri.parse('https://ronaldo.gtasamp.com.br/api/trade/product');
    List<String> listaString = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
            "Access-Control-Allow-Credentials": 'true',
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST"
          },
          body: jsonEncode(
              <String, String>{'new_user': newUser, 'product_name': name}));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['data'] != null && data['data']['message'] != null) {
          String message = data['data']['message'];

          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 10,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            webShowClose: true,
            webPosition: 'center',
          );

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        }
      } else if (response.statusCode == 401) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['data']['message'] != null) {
          String errorMessage = data['data']['message'];

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                errorMessage,
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
      } else if (response.statusCode >= 500) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['message'] != null && data['message']['erros'] != null) {
          List<String> erros = List<String>.from(
              data['message']['erros'].map((item) => item.toString()));

          if (erros.isNotEmpty) {
            listaString.addAll(erros);
          }

          String errorMessage = erros.join('\n');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Ops! Ocorreu um erro:\n$errorMessage',
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Ops! Ocorreu algum erro interno',
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
              decoration: BoxDecoration(
                color: Colors.blueGrey[900],
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: GestureDetector(
                      onTap: () => showManualOrDriver(context),
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
                  GestureDetector(
                    onTap: () => showManualOrDriver(context),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.touch_app_outlined,
                        size: 30,
                        color: Color(0xffA49930),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 260,
                    left: 200,
                    child: GestureDetector(
                      onTap: () {
                        showAlertTransferencia(context, product);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(172, 198, 40, 40),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.autorenew_rounded,
                              size: 15,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Transferir',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Rubik',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 288,
              height: 60,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Color(0xffA49930),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(35),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 3),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
                        fontSize: 14,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showConfirmationDialog(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 3, top: 4),
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.only(right: 110),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(35),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 38, 50, 56),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 15,
                              color: Color(0xffA49930),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Garantia: ${product.garantia}',
                              style: TextStyle(
                                color: Color(0xffA49930),
                                fontFamily: 'Rubik',
                                fontSize: 14,
                              ),
                            ),
                          ],
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
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
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
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      'Agradecemos por escolher nosso produto e nos honrar com sua confiança. Temos o compromisso de oferecer produtos de alta qualidade e durabilidade, e para reforçar nosso compromisso, fornecemos a seguinte garantia genérica para sua tranquilidade.\n\n'
                      '1. Cobertura da Garantia\n'
                      'Garantimos que o produto estará livre de defeitos de fabricação e funcionará conforme as especificações indicadas no momento da compra. Esta garantia cobre tanto os componentes físicos quanto o desempenho do produto, desde que seja utilizado de acordo com as instruções fornecidas.\n\n'
                      '2. Prazo da Garantia\n'
                      'A garantia é válida por um período vitalício em caso de compra direta em um parceiro VTR ou pelo período de 1 ano a partir da data de compra por revenda. Durante esse período, caso o produto apresente algum defeito coberto pela garantia, providenciaremos o reparo ou a substituição do produto, de acordo com nossa política de garantia.\n\n'
                      '3. Exclusões da Garantia\n'
                      'Esta garantia não cobre danos causados por mau uso, negligência, acidentes, manutenção inadequada, reparos não autorizados, modificações não autorizadas, uso indevido ou qualquer outra circunstância que não se enquadre nas condições normais de utilização do produto.\n\n'
                      '4. Processo de Acionamento da Garantia\n'
                      'Caso você identifique um defeito coberto pela garantia durante o período de cobertura, solicitamos que entre em contato com nosso serviço de atendimento ao cliente. Faremos o possível para resolver o problema de maneira rápida e eficiente. Podemos solicitar informações adicionais, como comprovante de compra, número de série do produto, descrição do defeito, entre outros, para agilizar o processo de atendimento.\n\n'
                      '5. Opções de Reparo ou Substituição\n'
                      'Após a avaliação do produto, caso seja constatado um defeito coberto pela garantia, ofereceremos as seguintes opções:\n'
                      'a) Reparo: Providenciaremos o conserto do produto sem custos adicionais para você. Faremos o possível para realizar o reparo de forma ágil e eficaz.\n'
                      'b) Substituição: Caso o reparo não seja viável ou se o produto apresentar repetidos problemas, ofereceremos a substituição por um produto idêntico ou similar, de acordo com nossa disponibilidade.\n\n'
                      '6. Limitações da Garantia\n'
                      'Nossa responsabilidade, limitada à reparação ou substituição conforme descrito nesta garantia, exclui qualquer outra responsabilidade por danos diretos, indiretos, incidentais ou consequenciais, incluindo perda de uso, perda de dados, perda de lucros ou qualquer outro tipo de perda financeira.\n\n'
                      '7. Legislação Aplicável\n'
                      'Esta garantia é regida pelas leis do país/estado/jurisdição aplicável. Quaisquer disputas relacionadas a esta garantia serão resolvidas por meio dos tribunais competentes da mesma.\n\n'
                      'Esperamos que este texto de garantia genérica tenha esclarecido suas dúvidas. Para informações mais específicas sobre a garantia do seu produto, consulte o documento de garantia fornecido juntamente com o produto ou entre em contato com nosso serviço de atendimento ao cliente.\n\n'
                      'Atenciosamente,\n'
                      'ÍTALO\n'
                      'VTR EFFECTS',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffA49930),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Estou Ciente'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
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

  void showAlertTransferencia(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  child: Icon(
                Icons.warning,
                size: 60,
                color: Colors.red,
              )),
              SizedBox(width: 10),
              Text(
                'Atenção!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ],
          ),
          content: Text(
              'Você está prestes a realizar a tranferência do seu produto. Tem certeza que deseja continuar?',
              textAlign: TextAlign.center),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop();
                showTransferencia(context, product);
                FocusScope.of(context).unfocus();
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
              child: Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showConfirmationTransferencia(
      BuildContext context, String newUser, String name) {
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
                  'Confirmação Irreversível!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Ao confirmar a transferência, o produto será permanentemente transferido para $newUser e você não poderá desfazer essa ação. Tem certeza de que deseja prosseguir?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
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
                          'Sim, confirmo!',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          transfeProduct(newUser, name);
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
                          'Não, desisti!',
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

  void showTransferencia(BuildContext context, Product product) {
    String newUser = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          'Transferir Produto',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Informe o e-mail do novo dono do Pedal',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 167, 155, 48),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          validator: _validateEmailTransferencia,
                          onChanged: (value) => newUser = value,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Color(0xFFA49930),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFA49930),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.of(context).pop();
                              showConfirmationTransferencia(
                                  context, newUser, product.name);
                              FocusScope.of(context).unfocus();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFA49930),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text('Transferir'),
                        ),
                        SizedBox(height: 12),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Color(0xFFA49930),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Fechar',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showManualOrDriver(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
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
                SizedBox(height: 16),
                Text(
                  'Opa, parece que você está interessado em saber mais sobre seu produto, não é mesmo? haha. Nos botões abaixo você tem acesso à área de manual do seu produto ou então, se for um guitarrista veterano, pode verificar a nova atualização de seu pedal.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffA49930),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Acessar o Manual',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      _launchManual();
                    },
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffA49930),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Baixar Nova Atualização',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      _launchDriver();
                    },
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      side: BorderSide(color: Color(0xffA49930)),
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Voltar',
                      style: TextStyle(fontSize: 16, color: Color(0xffA49930)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
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
