import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:musync/config/constants/api_endpoints.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/network/api/api.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

class AuthDataSource {
  final Api api;

  AuthDataSource({
    required this.api,
  });

  Future<Either<ErrorModel, Map<String, dynamic>>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final socket = socket_io.io(ApiEndpoints.baseURL, <String, dynamic>{
        'transports': ['websocket'],
      });
      // Handle the connection event (optional).
      socket.onConnect((_) {
        print('WebSocket connected!');
      });
      // Handle custom authentication event.
      socket.on('authenticated', (_) {
        print('WebSocket authenticated!');
        // Now you can start listening for other events or sending messages.
        // For example: socket.on('message', (data) => print(data));
      });
      // Send the session token to authenticate the WebSocket connection.

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
        // Replace 'your_received_token_here' with the token received after successful login.
        socket.emit('authenticate', token);
        return Right(userData);
      } else {
        return Left(
          ErrorModel(
            message: responseApi.message.toString(),
            status: false,
          ),
        );
      }
    } on DioError catch (e) {
      if (e.response != null) {
        var responseApi = ApiResponse.fromResponse(e.response!);
        return Left(
          ErrorModel(
            message: responseApi.message.toString(),
            status: false,
          ),
        );
      } else {
        return Left(
          ErrorModel(
            message: 'An unexpected error occurred.',
            status: false,
          ),
        );
      }
    } catch (e) {
      return Left(
        ErrorModel(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  Future<Either<ErrorModel, Map<String, dynamic>>> signupUser({
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
        return Right(userData);
      } else {
        return Left(
          ErrorModel(
            message: responseApi.message.toString(),
            status: false,
          ),
        );
      }
    } on DioError catch (e) {
      if (e.response != null) {
        var responseApi = ApiResponse.fromResponse(e.response!);
        return Left(
          ErrorModel(
            message: responseApi.message.toString(),
            status: false,
          ),
        );
      } else {
        return Left(
          ErrorModel(
            message: "Network error occurred.",
            status: false,
          ),
        );
      }
    } catch (e) {
      return Left(
        ErrorModel(
          message: 'An unexpected error occurred.',
          status: false,
        ),
      );
    }
  }

  Future<Either<ErrorModel, void>> logout() async {
    try {
      await GetIt.instance<HiveQueries>().deleteValue(
        boxName: 'users',
        key: 'token',
      );
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorModel(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  Future<Either<ErrorModel, Map<String, dynamic>>> google() async {
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
          var loggedUser =
              await loginUser(email: user.email, password: user.id);

          return loggedUser;
        } else {
          return Left(
            ErrorModel(
              message: responseApi.message.toString(),
              status: false,
            ),
          );
        }
      } else {
        return Left(
          ErrorModel(
            message: 'Google sign in failed.',
            status: false,
          ),
        );
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
            var loggedUser =
                await loginUser(email: user.email, password: user.id);

            return loggedUser;
          } else {
            return Left(
              ErrorModel(
                message: 'Google sign in failed.',
                status: false,
              ),
            );
          }
        } else {
          return Left(
            ErrorModel(
              message: responseApi.message.toString(),
              status: false,
            ),
          );
        }
      } else {
        return Left(
          ErrorModel(
            message: 'An unexpected error occurred.',
            status: false,
          ),
        );
      }
    } catch (e) {
      return Left(
        ErrorModel(
          message: 'An unexpected error occurred.',
          status: false,
        ),
      );
    }
  }
}
