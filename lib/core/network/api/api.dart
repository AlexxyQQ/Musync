import 'package:dio/dio.dart';
import 'package:musync/config/constants/api/api_endpoints.dart';
import 'package:musync/core/network/api/dio_error_interceptor.dart';
import "package:pretty_dio_logger/pretty_dio_logger.dart";
import 'package:socket_io_client/socket_io_client.dart' as io;

class Api {
  final Dio _dio = Dio();

  final io.Socket _socket = io.io(
    ApiEndpoints.socketURL,
    <String, dynamic>{
      'transports': ['websocket'],
    },
  );

  Api() {
    _dio
      ..options.baseUrl = ApiEndpoints.baseURL
      ..options.headers = ApiEndpoints.defaultHeaders
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      // ..httpClientAdapter = HttpClientAdapter()
      ..interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: true,
        ),
      )
      ..interceptors.add(DioErrorInterceptor());
  }

  Dio get sendRequest => _dio;

  io.Socket get getSocket => _socket;
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
