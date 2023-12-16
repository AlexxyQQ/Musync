import 'package:dartz/dartz.dart';

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

  GetAllAlbumsUsecase({
    required this.audioQueryRepository,
    required this.queryHiveService,
  });
  @override
  Future<Either<AppErrorHandler, List<AlbumEntity>>> call(
    GetQueryParams params,
  ) async {
    try {
      final data = await audioQueryRepository.getAllAlbums(
        refetch: params.refetch ?? false,
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
