import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';

abstract class ISplashRepository {
  Future<Either<ErrorModel, UserEntity>> initialLogin({
    required String token,
  });
}
