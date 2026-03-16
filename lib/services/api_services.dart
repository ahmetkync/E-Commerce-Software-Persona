import 'dart:convert';
import 'package:e_commerce_software_persona/model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<ProductModel> fetchProducts() async {
    final response = await http.get(
      Uri.parse("https://wantapi.com/products.php"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ProductModel.fromJson(data);
    } else {
      throw Exception('Failed to load products.');
    }
  }
}
