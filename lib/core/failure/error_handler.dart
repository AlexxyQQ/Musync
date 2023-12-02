import 'dart:convert';

import 'package:dio/dio.dart';

class AppErrorHandler {
  final String message;
  final dynamic data;
  final bool status;

  AppErrorHandler({
    required this.message,
    this.data,
    required this.status,
  });

  @override
  String toString() {
    return 'App Error Handler Details:\n'
        '  - Message: $message\n'
        '  - Data: $data\n'
        '  - Status: $status';
  }

  // on DioError
  factory AppErrorHandler.fromDioError(DioError error) {
    String message = error.message;
    dynamic data = error.response?.data;
    bool status = false;

    if (error.type == DioErrorType.response) {
      message = error.response?.data['message'];
      data = error.response?.data;
      status = false;
    } else if (error.type == DioErrorType.other) {
      message = error.message;
      data = error.response?.data;
      status = false;
    } else if (error.type == DioErrorType.connectTimeout) {
      message = error.message;
      data = error.response?.data;
      status = false;
    } else if (error.type == DioErrorType.receiveTimeout) {
      message = error.message;
      data = error.response?.data;
      status = false;
    } else if (error.type == DioErrorType.sendTimeout) {
      message = error.message;
      data = error.response?.data;
      status = false;
    } else if (error.type == DioErrorType.cancel) {
      message = error.message;
      data = error.response?.data;
      status = false;
    } else {
      message = error.message;
      data = error.response?.data;
      status = false;
    }

    return AppErrorHandler(
      message: message,
      data: data,
      status: status,
    );
  }

  AppErrorHandler copyWith({
    String? message,
    dynamic data,
    bool? status,
  }) {
    return AppErrorHandler(
      message: message ?? this.message,
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'data': data,
      'status': status,
    };
  }

  factory AppErrorHandler.fromMap(Map<String, dynamic> map) {
    return AppErrorHandler(
      message: map['message'] as String,
      data: map['data'] as dynamic,
      status: map['status'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppErrorHandler.fromJson(String source) =>
      AppErrorHandler.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant AppErrorHandler other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.data == data &&
        other.status == status;
  }

  @override
  int get hashCode => message.hashCode ^ data.hashCode ^ status.hashCode;
}
