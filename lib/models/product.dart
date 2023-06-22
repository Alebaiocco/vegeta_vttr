import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vttr/models/product_comment.dart';
import 'package:vttr/repository/product.dart';

class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  final String product_image;
  final String link_yt;
  final String link_manual;
  final String link_driver;

  Future<List<ProductComment>>? comments;

  Product(
    this.id,
    this.name,
    this.price,
    this.description,
    this.product_image,
    this.link_yt,
    this.link_manual,
    this.link_driver,
  ) {
    try {
      comments = fetchComments();
    } catch (e) {
      comments = null;
    }
  }

  Product copyWith({
    int? id,
    String? name,
    double? price,
    String? description,
    String? product_image,
    String? link_yt,
    String? link_manual,
    String? link_driver,
  }) {
    return Product(
      id ?? this.id,
      name ?? this.name,
      price ?? this.price,
      description ?? this.description,
      product_image ?? this.product_image,
      link_yt ?? this.link_yt,
      link_manual ?? this.link_manual,
      link_driver ?? this.link_driver,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'product_image': product_image,
      'link_yt': link_yt,
      'link_manual': link_manual,
      'link_driver': link_driver,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      map['id'] as int,
      map['name'] as String,
      map['price'] as double,
      map['description'] as String,
      map['product_image'] as String,
      map['link_yt'] as String,
      map['link_manual'] as String,
      map['link_driver'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, description: $description, product_image: $product_image, link_yt: $link_yt, link_manual: $link_manual, link_driver: $link_driver)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.price == price &&
        other.description == description &&
        other.product_image == product_image &&
        other.link_yt == link_yt &&
        other.link_manual == link_manual &&
        other.link_driver == link_driver;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        description.hashCode ^
        product_image.hashCode ^
        link_yt.hashCode ^
        link_manual.hashCode ^
        link_driver.hashCode;
  }

  Future<double> fetchAssessment() async {
    try {
      ProductRepositoryImpl().fetchProductAssessment(id);

    }
    catch(e) {

    }
    return 0.0;
  }

  Future<List<ProductComment>> fetchComments() async {
    try {
      final response = await Dio().get(
        'https://ronaldo.gtasamp.com.br/api/showcomment/$id',
      );

      final data = response.data['data']['comment'] as List<dynamic>;

      List<ProductComment> comments = [];
      for (var commentData in data) {
        ProductComment comment = ProductComment(
          User: commentData['User'],
          comment: commentData['comment'],
          assessment: commentData['assessment'],
        );
        comments.add(comment);
      }

      return comments;
    } catch (e) {
      print(e);
      throw Exception('Falha ao buscar os comentários.');
    }
  }
}
