import 'dart:developer';

import 'package:dio/dio.dart';

class AuthDataSource {
  final Dio dio = Dio();

  Future<bool> signUp({
    required String name,
    required String email,
    required String pass,
    required String phoneNumber,
  }) async {
    try {
      final response = await dio.post(
        'https://talabat639.runasp.net/api/Account/Register',
        data: {
          'displayName': name,
          'email': email,
          'password': pass,
          'phoneNumber': phoneNumber,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? 'Error Signup');
      throw Exception('فشل إنشاء الحساب، تأكد من البيانات');
    }
  }

  Future<bool> login({required String email, required String pass}) async {
    try {
      final response = await dio.post(
        'https://talabat639.runasp.net/api/Account/Login',
        data: {'email': email, 'password': pass},
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? 'Error Login');
      throw Exception('فشل تسجيل الدخول، تأكد من البيانات');
    }
  }
}
