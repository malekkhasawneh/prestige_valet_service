import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';

class DioHelper {
  static final DioHelper _instance = DioHelper._internal();
  static final Dio _dio = Dio(
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

  static Future<Map<String, dynamic>> get(
    String endpoint,
  ) async {
    try {
      final response = await _dio.get(endpoint);
      return response.data;
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
