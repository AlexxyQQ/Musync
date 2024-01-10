import 'package:dartz/dartz.dart';
import 'package:musync/core/common/hive/hive_service/setting_hive_service.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/usecase/usecase.dart';
import 'package:musync/features/home/domain/repository/audio_query_repository.dart';

class GetLyricsUseCase extends UseCase<String, GetLyricsParams> {
  final IAudioQueryRepository audioQueryRepository;
  final SettingsHiveService settingsHiveService;

  GetLyricsUseCase({
    required this.audioQueryRepository,
    required this.settingsHiveService,
  });

  @override
  Future<Either<AppErrorHandler, String>> call(GetLyricsParams params) async {
    try {
      final setting = await settingsHiveService.getSettings();

      if (setting.token == null && !setting.offline) {
        return Left(
          AppErrorHandler(
            message: 'No Token',
            status: false,
          ),
        );
      }

      final data = await audioQueryRepository.getLyrics(
        artist: params.artist,
        title: params.title,
        songId: params.songId,
        token: setting.token ?? '',
      );

      return data;
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

class GetLyricsParams {
  final String artist;
  final String title;
  final int songId;

  GetLyricsParams({
    required this.artist,
    required this.title,
    required this.songId,
  });
}
