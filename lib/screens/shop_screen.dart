// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:vttr/models/product.dart';
import 'package:vttr/repository/product.dart';
import 'package:vttr/widgets/product_widget.dart';
import 'package:vttr/components/top_bar.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final repository = ProductRepositoryImpl();
  List<Product> products = [];
  var isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<void> getProducts() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await repository.getProducts();

      products = response;
    } catch (e) {
      error = e.toString();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget mountBody() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (error != null) {
      return Center(
        child: Text(error!),
      );
    } else {
      return Column(
        children: products
            .map<Widget>(
              (product) => ProductWidget(product: product),
            )
            .toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000915),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(text: 'Conheça nossos Produtos', text2: ''),
              const Divider(
                thickness: 2,
                color: Color(0xffA49930),
              ),
              mountBody(),
            ],
          ),
        ),
      ),
    );
  }
}
