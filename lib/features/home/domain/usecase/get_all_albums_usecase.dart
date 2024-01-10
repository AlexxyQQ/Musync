import 'package:dartz/dartz.dart';
import 'package:musync/core/common/hive/hive_service/setting_hive_service.dart';

import '../../../../core/failure/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/data_source/local_data_source/hive_service/query_hive_service.dart';
import '../../data/model/hive/album_hive_model.dart';
import '../entity/album_entity.dart';
import '../repository/audio_query_repository.dart';
import 'get_all_songs_usecase.dart';

class GetAllAlbumsUsecase extends UseCase<List<AlbumEntity>, GetQueryParams> {
  final IAudioQueryRepository audioQueryRepository;
  final QueryHiveService queryHiveService;
  final SettingsHiveService settingsHiveService;

  GetAllAlbumsUsecase({
    required this.audioQueryRepository,
    required this.queryHiveService,
    required this.settingsHiveService,
  });
  @override
  Future<Either<AppErrorHandler, List<AlbumEntity>>> call(
    GetQueryParams params,
  ) async {
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
      final data = await audioQueryRepository.getAllAlbums(
        refetch: params.refetch ?? false,
        token: setting.token ?? '',
      );
      return data.fold(
        (l) => Left(l),
        (r) async {
          final List<AlbumHiveModel> convertedHiveAlbums = r
              .map(
                (e) => AlbumHiveModel.fromMap(
                  e.toMap(),
                ),
              )
              .toList();
          await queryHiveService.addAlbums(convertedHiveAlbums);
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
