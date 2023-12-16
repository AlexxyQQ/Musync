import 'package:dartz/dartz.dart';

import '../../../../core/failure/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/data_source/local_data_source/hive_service/query_hive_service.dart';
import '../../data/model/hive/artist_hive_model.dart';
import '../entity/artist_entity.dart';
import '../repository/audio_query_repository.dart';
import 'get_all_songs_usecase.dart';

class GetAllArtistsUsecase extends UseCase<List<ArtistEntity>, GetQueryParams> {
  final IAudioQueryRepository audioQueryRepository;
  final QueryHiveService queryHiveService;

  GetAllArtistsUsecase({
    required this.audioQueryRepository,
    required this.queryHiveService,
  });
  @override
  Future<Either<AppErrorHandler, List<ArtistEntity>>> call(
    GetQueryParams params,
  ) async {
    try {
      final data = await audioQueryRepository.getAllArtists(
        refetch: params.refetch ?? false,
      );
      return data.fold(
        (l) => Left(l),
        (r) async {
          final List<ArtistHiveModel> convertedHiveArtists = r
              .map(
                (e) => ArtistHiveModel.fromMap(
                  e.toMap(),
                ),
              )
              .toList();
          await queryHiveService.addArtists(convertedHiveArtists);
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
