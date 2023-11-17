import 'package:dio/dio.dart';

class NetworkUtils {
  NetworkUtils._privateConstructor();

  static final NetworkUtils _instance = NetworkUtils._privateConstructor();
  final Dio _dio = Dio();

  Dio get dio => _dio;
  static const String baseUrl = 'https://api.example.com';

  factory NetworkUtils() {
    return _instance;
  }

  Future<Map<String, dynamic>> getData(String path) async {
    try {
      final response = await _dio.get('$baseUrl/$path');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<Map<String, dynamic>> postData(
      String path, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('$baseUrl/$path', data: data);
      return response.data;
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }
}
