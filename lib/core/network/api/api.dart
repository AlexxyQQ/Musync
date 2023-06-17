import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String baseURL = "http://192.168.1.78:3001/api";
const Map<String, dynamic> defaultHeaders = {'apisecret': "Apple"};

class Api {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseURL,
      headers: defaultHeaders,
      contentType: "application/json",
      connectTimeout: const Duration(seconds: 3),
    ),
  );

  Api() {
    // _dio.interceptors.add(
    //   PrettyDioLogger(
    //     requestBody: true,
    //     requestHeader: true,
    //     responseBody: true,
    //     responseHeader: true,
    //   ),
    // );
    _dio.httpClientAdapter = HttpClientAdapter();
  }

  Dio get sendRequest => _dio;
}

class ApiResponse {
  bool success;
  dynamic data;
  String? message;

  ApiResponse({required this.success, this.data, this.message});

  factory ApiResponse.fromResponse(Response response) {
    try {
      final data = response.data as Map<String, dynamic>;
      return ApiResponse(
        success: data["success"],
        data: data["data"],
        message: data["message"] ?? "Unexpected error",
      );
    } catch (e) {
      rethrow;
    }
  }
}
