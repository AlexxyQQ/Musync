import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:musync/config/constants/api_endpoints.dart';
import 'package:musync/core/network/api/api.dart';
import 'package:musync/core/network/hive/hive_queries.dart';

class AuthDataSource {
  final Api api;

  const AuthDataSource({required this.api});

  Future<Map<String, dynamic>> getUser({
    required String token,
  }) async {
    try {
      final response = await api.sendRequest.get(
        ApiEndpoints.loginWithTokenRoute,
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
        return userData;
      } else {
        throw Exception(responseApi.message.toString());
      }
    } on DioError catch (e) {
      if (e.response != null) {
        ApiResponse responseApi = ApiResponse.fromResponse(e.response!);
        throw Exception(responseApi.message.toString());
      } else {
        throw ('Network error occurred.');
      }
    } catch (e) {
      throw ('An unexpected error occurred.');
    }
  }

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.sendRequest.post(
        ApiEndpoints.loginRoute,
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
        return userData;
      } else {
        throw (responseApi.message.toString());
      }
    } on DioError catch (e) {
      if (e.response != null) {
        var responseApi = ApiResponse.fromResponse(e.response!);
        throw (responseApi.message.toString());
      } else {
        throw ('Network error occurred.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> signupUser({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final response = await api.sendRequest.post(
        ApiEndpoints.signupRoute,
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
        return userData;
      } else {
        throw (responseApi.message.toString());
      }
    } on DioError catch (e) {
      if (e.response != null) {
        var responseApi = ApiResponse.fromResponse(e.response!);
        throw (responseApi.message.toString());
      } else {
        throw ('Network error occurred.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await GetIt.instance<HiveQueries>().deleteValue(
      boxName: 'users',
      key: 'token',
    );
  }

  Future<Map<String, dynamic>> google() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final user = await googleSignIn.signIn();
    try {
      if (user != null) {
        // User signup
        final response = await api.sendRequest.post(
          ApiEndpoints.signupRoute,
          data: jsonEncode({
            "username": user.displayName.toString().toLowerCase(),
            "email": user.email,
            "password": user.id,
            "confirmPassword": user.id,
            "profilePic": user.photoUrl,
            "type": "google",
          }),
        );

        ApiResponse responseApi = ApiResponse.fromResponse(response);
        if (responseApi.success) {
          // Login user
          Map<String, dynamic> loggedUser =
              await loginUser(email: user.email, password: user.id);

          return loggedUser;
        } else {
          throw (responseApi.message.toString());
        }
      } else {
        throw ('Google sign in failed.');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        var responseApi = ApiResponse.fromResponse(e.response!);
        if (responseApi.message.toString() ==
                'User with same USERNAME already exists!' ||
            responseApi.message.toString() ==
                'User with same EMAIL already exists!') {
          //
          if (user != null) {
            // Login user
            Map<String, dynamic> loggedUser =
                await loginUser(email: user.email, password: user.id);

            return loggedUser;
          } else {
            throw ('Google sign in failed.');
          }
        } else {
          throw (responseApi.message.toString());
        }
      } else {
        throw ('Network error occurred.');
      }
    } catch (e) {
      rethrow;
    }
  }
}
