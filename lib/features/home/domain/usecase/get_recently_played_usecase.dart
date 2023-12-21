import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/usecase/usecase.dart';
import 'package:musync/features/home/data/data_source/local_data_source/hive_service/query_hive_service.dart';
import 'package:musync/features/home/data/model/hive/song_hive_model.dart';
import 'package:musync/features/home/domain/entity/recently_played_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class GetRecentlyPlayedUsecase extends UseCase<RecentlyPlayedEntity, void> {
  final QueryHiveService queryHiveService;

  GetRecentlyPlayedUsecase({
    required this.queryHiveService,
  });

  @override
  Future<Either<AppErrorHandler, RecentlyPlayedEntity>> call(
    void params,
  ) async {
    try {
      final data = await queryHiveService.getRecentlyPlayed();

      // Convert the data to the entity
      final RecentlyPlayedEntity convertedData =
          RecentlyPlayedEntity.fromMap(data.toMap());

      return Right(convertedData);
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

// Update the hive by addeing a specific song
class UpdateRecentlyPlayedUsecase extends UseCase<void, SongEntity> {
  final QueryHiveService queryHiveService;

  UpdateRecentlyPlayedUsecase({
    required this.queryHiveService,
  });

  @override
  Future<Either<AppErrorHandler, void>> call(
    SongEntity params,
  ) async {
    try {
      // convert the song entity to the app
      final SongHiveModel convertedSong = SongHiveModel.fromMap(params.toMap());

      final data = await queryHiveService.getRecentlyPlayed();

      await queryHiveService.updateRecentlyPlayed(
        data.copyWith(
          songs: [...data.songs, convertedSong],
        ),
      );
      return const Right(null);
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
