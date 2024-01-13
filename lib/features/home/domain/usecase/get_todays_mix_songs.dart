import 'package:dartz/dartz.dart';
import 'package:musync/core/common/hive/hive_service/setting_hive_service.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/usecase/usecase.dart';
import 'package:musync/features/home/data/data_source/local_data_source/hive_service/query_hive_service.dart';
import 'package:musync/features/home/data/model/hive/song_hive_model.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/domain/repository/audio_query_repository.dart';
import 'package:musync/features/home/domain/usecase/get_all_songs_usecase.dart';
import 'package:musync/injection/app_injection_container.dart';

class GetTodaysMixSongsUseCase extends UseCase<List<SongEntity>, void> {
  final IAudioQueryRepository audioQueryRepository;
  final QueryHiveService queryHiveService;
  final SettingsHiveService settingsHiveService;

  GetTodaysMixSongsUseCase({
    required this.audioQueryRepository,
    required this.queryHiveService,
    required this.settingsHiveService,
  });

  @override
  Future<Either<AppErrorHandler, List<SongEntity>>> call(params) async {
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

      final data = await audioQueryRepository.getTodaysMixSongs(
        token: setting.token ?? '',
      );
      return data.fold(
        (l) => Left(l),
        (r) async {
          return Right(r);
        },
      );
      // }
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
