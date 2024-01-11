import 'package:dartz/dartz.dart';
import 'package:musync/core/common/hive/hive_service/setting_hive_service.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/usecase/usecase.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/domain/repository/audio_query_repository.dart';
import 'package:musync/features/home/domain/usecase/update_song_usecase.dart';

class GetLyricsUseCase extends UseCase<String, GetLyricsParams> {
  final IAudioQueryRepository audioQueryRepository;
  final SettingsHiveService settingsHiveService;
  final UpdateSongUsecase updateSongUsecase;

  GetLyricsUseCase({
    required this.audioQueryRepository,
    required this.settingsHiveService,
    required this.updateSongUsecase,
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
        artist: params.song.artist!,
        title: params.song.title,
        songId: params.song.id,
        token: setting.token ?? '',
      );

      data.fold(
        (error) => Left(
          AppErrorHandler(
            message: error.message,
            status: false,
          ),
        ),
        (lyrics) async {
          await updateSongUsecase(
            UpdateParams(
              song: params.song.copyWith(lyrics: lyrics),
              offline: true,
            ),
          );
        },
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
  final SongEntity song;

  GetLyricsParams({
    required this.song,
  });
}
