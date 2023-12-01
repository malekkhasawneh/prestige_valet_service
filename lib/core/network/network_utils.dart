import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prestige_valet_app/core/helpers/cache_helper.dart';
import 'package:prestige_valet_app/core/resources/cache_constants.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';

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

  static Map<String, String> headers(token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

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

  static Future<Map<String, dynamic>> put(String endpoint,
      {Map<String, dynamic> data = const {}}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  static Future<bool> uploadImage(
      File imageFile, BuildContext context, int userId) async {
    final url =
        Uri.parse(NetworkConstants.baseUrl + NetworkConstants.addUserImage);
    var request = http.MultipartRequest('POST', url);
    request.fields['userId'] = userId.toString();
    var pic = await http.MultipartFile.fromPath('image', imageFile.path);
    request.files.add(pic);
    headers(await CacheHelper.getValue(key: CacheConstants.appToken))
        .forEach((key, value) {
      request.headers[key] = value == 'Bearer token'
          ? 'Bearer ${HomeCubit.get(context).userModel.token}'
          : value;
    });
    var response = await request.send();
    if (response.statusCode == 202) {
      return true;
    } else {
      return false;
    }
  }

  static dynamic _handleError(error) {
    log('Dio Error: $error');
    return error;
  }
}
