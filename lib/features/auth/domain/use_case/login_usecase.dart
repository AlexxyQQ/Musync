import 'package:dartz/dartz.dart';
import 'package:musync/core/common/hive/hive_service/setting_hive_service.dart';
import '../../../../core/failure/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class LoginUseCase extends UseCase<UserEntity, LoginParams> {
  final IAuthRepository repository;
  final SettingsHiveService settingsHiveService;

  LoginUseCase({
    required this.repository,
    required this.settingsHiveService,
  });

  @override
  Future<Either<AppErrorHandler, UserEntity>> call(LoginParams params) async {
    final data = await repository.login(
      email: params.email,
      password: params.password,
    );

    final settings = await settingsHiveService.getSettings();

    return data.fold((l) => Left(l), (r) async {
      await settingsHiveService.updateSettings(
        settings.copyWith(
          token: r.token,
        ),
      );
      return Right(r);
    });
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
