import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';

abstract class UseCase<Type, Params> {
  Future<Either<AppErrorHandler, Type>> call(Params params);
}
