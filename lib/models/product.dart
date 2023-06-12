import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vttr/models/product_comment.dart';

class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  final String product_image;
  final DateTime created_at;
  final DateTime updated_at;
  Future<List<ProductComment>>? comments; // Alteração aqui

  Product(
    this.id,
    this.name,
    this.price,
    this.description,
    this.product_image,
    this.created_at,
    this.updated_at,
  ) {
    try {
      comments = fetchComments();
    }
    catch(e) {
      comments = null;
    }
  }

  Product copyWith({
    int? id,
    String? name,
    double? price,
    String? description,
    String? product_image,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return Product(
      id ?? this.id,
      name ?? this.name,
      price ?? this.price,
      description ?? this.description,
      product_image ?? this.product_image,
      created_at ?? this.created_at,
      updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'product_image': product_image,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      map['id'] as int,
      map['name'] as String,
      map['price'] as double,
      map['description'] as String,
      map['product_image'] as String,
      DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, description: $description, product_image: $product_image, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.price == price &&
        other.description == description &&
        other.product_image == product_image &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        description.hashCode ^
        product_image.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
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
