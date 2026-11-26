import 'dart:developer';
import 'package:dio/dio.dart';
import '../data/product_model.dart';

class DataService {
  final Dio dio = Dio();

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get(
        'https://talabat639.runasp.net/api/Products',
      );

      final List data = response.data['data'];

      return data
          .map((item) => ProductModel.fromJson(item))
          .toList();
    } catch (e) {
      log('Products Error: $e');
      rethrow;
    }
  }

  Future<List> getCategories() async {
    try {
      final response = await dio.get(
        'https://talabat639.runasp.net/api/Products/categories',
      );

      return response.data;
    } catch (e) {
      log('Categories Error: $e');
      rethrow;
    }
  }

  Future<List> getBrands() async {
    try {
      final response = await dio.get(
        'https://talabat639.runasp.net/api/Products/brands',
      );

      return response.data;
    } catch (e) {
      log('Brands Error: $e');
      rethrow;
    }
  }
}