import 'package:dartz/dartz.dart';
import 'package:musync/core/common/hive/hive_service/setting_hive_service.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/usecase/usecase.dart';
import 'package:musync/features/auth/domain/repository/auth_repository.dart';

class ResendVerificationUsecase extends UseCase<bool, String> {
  final IAuthRepository repository;
  final SettingsHiveService settingsHiveService;

  ResendVerificationUsecase({
    required this.repository,
    required this.settingsHiveService,
  });

  @override
  Future<Either<AppErrorHandler, bool>> call(params) async {
    try {
      final settings = await settingsHiveService.getSettings();
      if (settings.token == null) {
        return Left(
          AppErrorHandler(
            message: "No Token",
            status: false,
          ),
        );
      } else {
        return await repository.resendVerification(
          token: settings.token!,
        );
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
