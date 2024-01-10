import 'package:dartz/dartz.dart';
import 'package:musync/core/common/hive/hive_service/setting_hive_service.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/usecase/usecase.dart';
import 'package:musync/features/home/data/data_source/local_data_source/hive_service/query_hive_service.dart';
import 'package:musync/features/home/data/model/hive/song_hive_model.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/domain/repository/audio_query_repository.dart';
import 'package:musync/injection/app_injection_container.dart';

class GetAllSongsUseCase extends UseCase<List<SongEntity>, GetQueryParams> {
  final IAudioQueryRepository audioQueryRepository;
  final QueryHiveService queryHiveService;
  final SettingsHiveService settingsHiveService;

  GetAllSongsUseCase({
    required this.audioQueryRepository,
    required this.queryHiveService,
    required this.settingsHiveService,
  });

  @override
  Future<Either<AppErrorHandler, List<SongEntity>>> call(params) async {
    try {
      final setting = await settingsHiveService.getSettings();

      if (setting.token == null) {
        return Left(
          AppErrorHandler(
            message: 'No Token',
            status: false,
          ),
        );
      }

      final data = await audioQueryRepository.getAllSongs(
        onProgress: params.onProgress!,
        first: params.first,
        refetch: params.refetch ?? false,
        token: setting.token!,
      );
      return data.fold(
        (l) => Left(l),
        (r) async {
          if (r.isEmpty) {
            //
            get<SettingsHiveService>().updateSettings(
              await get<SettingsHiveService>().getSettings().then(
                    (value) => value.copyWith(
                      firstTime: true,
                    ),
                  ),
            );
          }

          if (params.refetch == true) {
            // clear the hive data
            await queryHiveService.deleteAllSongs();
            final List<SongHiveModel> convertedHiveSongs =
                SongEntity.toListHiveModel(r);
            await queryHiveService.addSongs(convertedHiveSongs);

            return Right(r);
          } else {
            final List<SongHiveModel> convertedHiveSongs =
                SongEntity.toListHiveModel(r);
            await queryHiveService.addSongs(convertedHiveSongs);

            return Right(r);
          }
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

class GetQueryParams {
  final Function(int)? onProgress;
  final bool? first;
  final bool? refetch;

  GetQueryParams({
    this.onProgress,
    this.first,
    this.refetch,
  });
}
