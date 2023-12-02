import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/usecase/usecase.dart';
import 'package:musync/features/home/data/data_source/local_data_source/hive_service/query_hive_service.dart';
import 'package:musync/features/home/data/model/hive/song_hive_model.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/domain/repository/audio_query_repository.dart';

class GetSongsUseCase extends UseCase<List<SongEntity>, GetSongsParams> {
  final IAudioQueryRepository audioQueryRepository;
  final QueryHiveService queryHiveService;

  GetSongsUseCase({
    required this.audioQueryRepository,
    required this.queryHiveService,
  });

  @override
  Future<Either<AppErrorHandler, List<SongEntity>>> call(params) async {
    try {
      final data = await audioQueryRepository.getAllSongs(
        onProgress: params.onProgress,
        first: params.first,
      );
      return data.fold(
        (l) => Left(l),
        (r) async {
          final List<SongHiveModel> convertedHiveSongs =
              r.map((e) => e.toHiveModel()).toList();
          await queryHiveService.addSongs(convertedHiveSongs);
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

class GetSongsParams {
  final Function(int) onProgress;
  final bool? first;

  GetSongsParams({
    required this.onProgress,
    this.first,
  });
}
