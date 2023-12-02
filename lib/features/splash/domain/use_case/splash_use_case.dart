import 'package:dartz/dartz.dart';
import 'package:musync/core/common/hive_service/setting_hive_service.dart';

import '../../../../core/failure/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../auth/domain/entity/user_entity.dart';
import '../repository/splash_repository.dart';

class InitialLoginUseCase extends UseCase<UserEntity, void> {
  final ISplashRepository splashRepository;
  final SettingsHiveService settingsHiveService;

  InitialLoginUseCase({
    required this.splashRepository,
    required this.settingsHiveService,
  });

  @override
  Future<Either<AppErrorHandler, UserEntity>> call(void params) async {
    try {
      final setting = await settingsHiveService.getSettings();

      if (setting.token == null) {
        return Left(
          AppErrorHandler(
            message: 'No Token',
            status: false,
          ),
        );
      } else {
        final response = await splashRepository.initialLogin(
          token: setting.token!,
        );
        return response;
      }
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
