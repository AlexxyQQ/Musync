import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';

abstract class UseCase<Type, Params> {
  Future<Either<ErrorModel, Type>> call(Params params);
}
