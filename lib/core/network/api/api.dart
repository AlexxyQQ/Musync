import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String baseURL = "http://192.168.1.78:3001/api";
const Map<String, dynamic> defaultHeaders = {
  "Content-Type": "application/json",
  'apisecret': "Apple"
};

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = baseURL;
    _dio.options.headers = defaultHeaders;
    _dio.options.connectTimeout = const Duration(seconds: 5);

    // _dio.interceptors.add(
    //   PrettyDioLogger(
    //     requestBody: true,
    //     requestHeader: true,
    //     responseBody: true,
    //     responseHeader: true,
    //   ),
    // );
  }

  Dio get sendRequest => _dio;
}

class ApiResponse {
  bool success;
  dynamic data;
  String? message;

  ApiResponse({required this.success, this.data, this.message});

  factory ApiResponse.fromResponse(Response response) {
    final data = response.data as Map<String, dynamic>;
    return ApiResponse(
      success: data["success"],
      data: data["data"],
      message: data["message"] ?? "Unexpected error",
    );
  }
}
