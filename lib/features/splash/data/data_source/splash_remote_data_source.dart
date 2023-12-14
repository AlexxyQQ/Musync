import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../config/constants/api/api_endpoints.dart';
import '../../../../core/failure/error_handler.dart';
import '../../../../core/network/api/api.dart';
import '../../../auth/data/dto/user_dto.dart';
import '../../../auth/data/model/user_model.dart';

class SplashRemoteDataSource {
  final Api api;

  const SplashRemoteDataSource({required this.api});

  Future<Either<AppErrorHandler, UserModel>> initialLogin({
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
        // Convert response to DTO
        UserDTO userDTO = UserDTO.fromMap(responseApi.data);
        if (userDTO.user?.verified ?? false) {
          // conver the DTO to Entity and return
          return Right(UserDTO.fromDTOtoEntity(userDTO));
        } else {
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
}
