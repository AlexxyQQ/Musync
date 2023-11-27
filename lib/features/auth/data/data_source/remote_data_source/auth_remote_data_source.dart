import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/core/failure/error_handler.dart';

import '../../../../../config/constants/api_endpoints.dart';
import '../../../../../core/network/api/api.dart';
import '../../../../../core/network/hive/hive_queries.dart';
import '../../dto/user_dto.dart';
import '../../model/user_model.dart';

class AuthRemoteDataSource {
  final Api api;

  AuthRemoteDataSource({
    required this.api,
  });

  Future<Either<AppErrorHandler, UserModel>> login({
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
        // Convert response to DTO
        UserDTO userDTO = UserDTO.fromMap(responseApi.data);
        if (userDTO.user?.verified ?? false) {
          // conver the DTO to Entity and return
          return Right(UserDTO.fromDTOtoEntity(userDTO));
        } else {
          // send OTP to user email and return error
          // ! Send OTP to user email
          return Left(
            AppErrorHandler(
              message: 'Please verify your email.',
              status: false,
            ),
          );
        }
      } else {
        return Left(
          AppErrorHandler(
            message: responseApi.message.toString(),
            status: false,
          ),
        );
      }
    } on DioError catch (e) {
      return Left(AppErrorHandler.fromDioError(e));
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  Future<Either<AppErrorHandler, UserModel>> signup({
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
        return right(
          UserModel.fromMap(
            responseApi.data,
          ),
        );
      } else {
        return Left(
          AppErrorHandler(
            message: responseApi.message.toString(),
            status: false,
          ),
        );
      }
    } on DioError catch (e) {
      return Left(AppErrorHandler.fromDioError(e));
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: 'An unexpected error occurred.',
          status: false,
        ),
      );
    }
  }

  Future<Either<AppErrorHandler, void>> logout() async {
    try {
      await GetIt.instance<HiveQueries>().deleteValue(
        boxName: 'users',
        key: 'token',
      );
      return const Right(null);
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  Future<Either<AppErrorHandler, UserModel>> uploadProfilePic({
    required String token,
    required String profilePicPath,
  }) async {
    try {
      final profilePicformData = FormData.fromMap({
        'profilePic': await MultipartFile.fromFile(profilePicPath),
      });
      final response = await api.sendRequest.post(
        ApiEndpoints.uploadProfilePicRoute,
        data: profilePicformData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      ApiResponse responseApi = ApiResponse.fromResponse(response);

      if (responseApi.success) {
        return Right(UserModel.fromMap(responseApi.data));
      } else {
        return Left(
          AppErrorHandler(
            message: responseApi.message.toString(),
            status: false,
          ),
        );
      }
    } on DioError catch (e) {
      return Left(AppErrorHandler.fromDioError(e));
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  Future<Either<AppErrorHandler, bool>> deleteUser({
    required String token,
  }) async {
    try {
      final response = await api.sendRequest.post(
        ApiEndpoints.deleteUserRoute,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      ApiResponse responseApi = ApiResponse.fromResponse(response);

      if (responseApi.success) {
        return const Right(true);
      } else {
        return Left(
          AppErrorHandler(
            message: responseApi.message.toString(),
            status: false,
          ),
        );
      }
    } on DioError catch (e) {
      return Left(AppErrorHandler.fromDioError(e));
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  Future<Either<AppErrorHandler, bool>> signupOTPValidator(
      {required String email, required String otp}) async {
    try {
      final response = await api.sendRequest.post(
        ApiEndpoints.signupOTPValidatorRoute,
        data: jsonEncode({
          "email": email,
          "otp": otp,
        }),
      );

      ApiResponse responseApi = ApiResponse.fromResponse(response);

      if (responseApi.success) {
        return const Right(true);
      } else {
        return Left(
          AppErrorHandler(
            message: responseApi.message.toString(),
            status: false,
          ),
        );
      }
    } on DioError catch (e) {
      return Left(AppErrorHandler.fromDioError(e));
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  Future<Either<AppErrorHandler, bool>> forgotPasswordOTPSender({
    required String email,
  }) async {
    try {
      final response = await api.sendRequest.post(
        ApiEndpoints.forgotPasswordOTPSenderRoute,
        data: jsonEncode({
          "email": email,
        }),
      );

      ApiResponse responseApi = ApiResponse.fromResponse(response);

      if (responseApi.success) {
        return const Right(true);
      } else {
        return Left(
          AppErrorHandler(
            message: responseApi.message.toString(),
            status: false,
          ),
        );
      }
    } on DioError catch (e) {
      return Left(AppErrorHandler.fromDioError(e));
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  Future<Either<AppErrorHandler, bool>> forgotPasswordOTPValidator({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      final response = await api.sendRequest.post(
        ApiEndpoints.forgotPasswordOTPValidatorRoute,
        data: jsonEncode({
          "email": email,
          "otp": otp,
          "newPassword": newPassword,
        }),
      );

      ApiResponse responseApi = ApiResponse.fromResponse(response);

      if (responseApi.success) {
        return const Right(true);
      } else {
        return Left(
          AppErrorHandler(
            message: responseApi.message.toString(),
            status: false,
          ),
        );
      }
    } on DioError catch (e) {
      return Left(AppErrorHandler.fromDioError(e));
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }
}
