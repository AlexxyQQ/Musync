import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:musync/config/constants/api_endpoints.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/network/api/api.dart';

class SplashRemoteDataSource {
  final Api api;

  const SplashRemoteDataSource({required this.api});

  Future<Either<ErrorModel, Map<String, dynamic>>> initialLogin({
    required String token,
    bool biometric = false,
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
        ApiResponse responseApi = ApiResponse.fromResponse(e.response!);
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
}
