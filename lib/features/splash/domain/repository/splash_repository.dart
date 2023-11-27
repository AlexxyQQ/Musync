import 'package:dartz/dartz.dart';

import '../../../../core/failure/error_handler.dart';
import '../../../auth/domain/entity/user_entity.dart';

abstract class ISplashRepository {
  Future<Either<AppErrorHandler, UserEntity>> initialLogin({
    required String token,
  });
}
