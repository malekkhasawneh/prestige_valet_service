import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';

class DioHelper {
  static final DioHelper _instance = DioHelper._internal();
  static Dio _dio = Dio(
    BaseOptions(
      baseUrl: NetworkConstants.baseUrl,
      receiveTimeout: const Duration(
        seconds: 7,
      ),
    ),
  );

  factory DioHelper() {
    return _instance;
  }

  DioHelper._internal();

  static Future<void> addTokenHeader() async {
    _dio = Dio(
      BaseOptions(
          baseUrl: NetworkConstants.baseUrl,
          receiveTimeout: const Duration(
            seconds: 7,
          ),
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtYWxla21hbW9vbjM0MUBnbWFpbC5jb20iLCJpYXQiOjE3MDExMDQyMTcsImV4cCI6MTcwNjI4ODIxN30.Y_ZEILuqJ-CMZjHB2Gt-9NZK5R1cCIPfKwTBH4-ihys',
            'Content-Type': 'application/json',
          }),
    );
  }

  static Future<Response> get(String endpoint) async {
    try {
      final response = await _dio.get(
        endpoint,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  static Future<Map<String, dynamic>> post(String endpoint,
      {Map<String, dynamic> data = const {}}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  static dynamic _handleError(error) {
    log('Dio Error: $error');
    return error;
  }
}
