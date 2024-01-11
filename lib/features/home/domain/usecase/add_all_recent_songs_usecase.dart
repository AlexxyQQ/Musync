import 'package:dartz/dartz.dart';
import 'package:musync/core/common/hive/hive_service/setting_hive_service.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/usecase/usecase.dart';
import 'package:musync/features/home/data/data_source/local_data_source/hive_service/query_hive_service.dart';
import 'package:musync/features/home/data/model/hive/song_hive_model.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/domain/repository/audio_query_repository.dart';
import 'package:musync/injection/app_injection_container.dart';

class AddAllRecentSongsUseCase extends UseCase<String, List<SongEntity>> {
  final IAudioQueryRepository audioQueryRepository;
  final QueryHiveService queryHiveService;
  final SettingsHiveService settingsHiveService;

  AddAllRecentSongsUseCase({
    required this.audioQueryRepository,
    required this.queryHiveService,
    required this.settingsHiveService,
  });

  @override
  Future<Either<AppErrorHandler, String>> call(List<SongEntity> params) async {
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

      final data = await audioQueryRepository.addRecentSongs(
        token: setting.token ?? '',
        songs: params,
      );
      return data.fold(
        (l) => Left(l),
        (r) => Right(r),
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
