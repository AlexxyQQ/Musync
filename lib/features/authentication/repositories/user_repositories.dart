import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:musync/common/api.dart';
import 'package:musync/common/local_storage_repository.dart';
import 'package:musync/features/authentication/data/models/user_model.dart';

class UserRepositories {
  final _api = Api();

  Future<UserModel> getUser({
    required String token,
  }) async {
    try {
      final response = await _api.sendRequest.get(
        "/users/loginWithToken",
        options: Options(
          headers: {
            "Authorization": 'Bearer $token',
          },
        ),
      );
      ApiResponse responseApi = ApiResponse.fromResponse(response);

      if (responseApi.success) {
        Map<String, dynamic> userData = responseApi.data['user'];
        String token = responseApi.data['token'];
        userData['token'] = token;
        return UserModel.fromMap(userData);
      } else {
        throw Exception(responseApi.message.toString());
      }
    } on DioError catch (e) {
      if (e.response != null) {
        ApiResponse responseApi = ApiResponse.fromResponse(e.response!);
        throw Exception(responseApi.message.toString());
      } else {
        throw Exception('Network error occurred.');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred.');
    }
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _api.sendRequest.post(
        "/users/login",
        data: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      ApiResponse responseApi = ApiResponse.fromResponse(response);

      if (responseApi.success) {
        Map<String, dynamic> userData = responseApi.data['user'];
        String token = responseApi.data['token'];
        userData['token'] = token;
        return UserModel.fromMap(userData);
      } else {
        throw (responseApi.message.toString());
      }
    } on DioError catch (e) {
      if (e.response != null) {
        var responseApi = ApiResponse.fromResponse(e.response!);
        throw (responseApi.message.toString());
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signup({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final response = await _api.sendRequest.post(
        "/users/signup",
        data: jsonEncode({
          "username": username,
          "email": email,
          "password": password,
          "confirmPassword": password,
          "type": "manual",
        }),
      );

      ApiResponse responseApi = ApiResponse.fromResponse(response);
      if (responseApi.success) {
        Map<String, dynamic> userData = responseApi.data;
        userData['token'] = '';
        return UserModel.fromMap(userData);
      } else {
        throw (responseApi.message.toString());
      }
    } on DioError catch (e) {
      if (e.response != null) {
        var responseApi = ApiResponse.fromResponse(e.response!);
        throw (responseApi.message.toString());
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await LocalStorageRepository().deleteValue(
      boxName: 'users',
      key: 'token',
    );
  }
}
