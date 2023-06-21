import 'package:dio/dio.dart';
import 'package:vttr/models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<void> addProductComment(
      String token, String comment, int assessment, String productName);
}

class ProductRepositoryImpl implements ProductRepository {
  final client = Dio();

  @override
  Future<List<Product>> getProducts() async {
    try {
      final response = await client
          .get("https://ronaldo.gtasamp.com.br/api/product/getAllProduct");

      final data = response.data['data']['products'] as List<dynamic>;

      return data.map<Product>((e) {
        return Product(
          e['id'] as int,
          e['name'] as String,
          double.parse(e['price'].toString()),
          e['description'] as String,
          "https://ronaldo.gtasamp.com.br/" + e['product_image'],
          e['link_yt'] as String,
          e['link_manual'] as String,
          e['link_driver'] as String,
        );
      }).toList();
    } catch (e) {
      print(e);
      throw Exception("Não foi possível buscar os produtos: $e");
    }
  }

  @override
  Future<void> addProductComment(
      String token, String comment, int assessment, String productName) async {
    try {
      final response = await client.post(
        'https://ronaldo.gtasamp.com.br/api/product/comments',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          'comment': comment,
          'assessment': assessment,
          'product_name': productName,
        },
      );

      final data = response.data['data'];
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.data != null) {
          final responseData = e.response!.data;
          if (responseData.containsKey('data') &&
              responseData['data'].containsKey('message')) {
            final errorMessage = responseData['data']['message'];
            print('Erro na requisição: $errorMessage');
            throw Exception("Voce ja fez um comentario para este produto!");
          }
        }
      }

      print('Erro na requisição: $e');
      throw Exception('Falha ao adicionar o comentário ao produto: $e');
    }
  }
}
