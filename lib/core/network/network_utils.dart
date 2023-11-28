import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prestige_valet_app/core/helpers/cache_helper.dart';
import 'package:prestige_valet_app/core/resources/cache_constants.dart';
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
                'Bearer ${await CacheHelper.getValue(key: CacheConstants.appToken)}',
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

  static Future<Map<String, dynamic>> patch(String endpoint,
      {Map<String, dynamic> data = const {}}) async {
    try {
      final response = await _dio.patch(endpoint, data: data);
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  static Map<String, dynamic> headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtYWxla21hbW9vbjM0MUBnbWFpbC5jb20iLCJpYXQiOjE3MDExMDk4MzcsImV4cCI6MTcwNjI5MzgzN30.Vc4-ZA6MtlD03a5iEHEOKQb-3dlcin8thHE5YfqPiis',
    'Content-Type': 'application/json',
  };

  static Future<bool> uploadImage(
      File imageFile, BuildContext context, int userId) async {
    final url =
        Uri.parse(NetworkConstants.baseUrl + NetworkConstants.addUserImage);
    var request = http.MultipartRequest('POST', url);
    request.fields['userId'] = userId.toString();
    var pic = await http.MultipartFile.fromPath('image', imageFile.path);
    request.files.add(pic);
    headers.forEach((key, value) {
      request.headers[key] = value;
    });
    var response = await request.send();
    if (response.statusCode == 202) {
      log('========================================= true');
      return true;
    } else {
      log('========================================= false');

      return false;
    }
  }

  static dynamic _handleError(error) {
    log('Dio Error: $error');
    return error;
  }
}
