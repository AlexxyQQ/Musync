import 'package:dartz/dartz.dart';
import 'package:musync/core/common/hive/hive_service/setting_hive_service.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/usecase/usecase.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/domain/repository/audio_query_repository.dart';

class UpdateSongUsecase extends UseCase<String, SongEntity> {
  final IAudioQueryRepository audioQueryRepository;
  final SettingsHiveService settingsHiveService;

  UpdateSongUsecase({
    required this.audioQueryRepository,
    required this.settingsHiveService,
  });

  @override
  Future<Either<AppErrorHandler, String>> call(SongEntity params) async {
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
        final response = await audioQueryRepository.updateSong(
          song: params,
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
