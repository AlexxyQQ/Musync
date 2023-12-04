import 'package:dartz/dartz.dart';

import '../../../../core/failure/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/data_source/local_data_source/hive_service/query_hive_service.dart';
import '../../data/model/hive/folder_hive_model.dart';
import '../entity/folder_entity.dart';
import '../repository/audio_query_repository.dart';
import 'get_all_songs_usecase.dart';

class GetAllFoldersUsecase extends UseCase<List<FolderEntity>, GetQueryParams> {
  final IAudioQueryRepository audioQueryRepository;
  final QueryHiveService queryHiveService;

  GetAllFoldersUsecase({
    required this.audioQueryRepository,
    required this.queryHiveService,
  });
  @override
  Future<Either<AppErrorHandler, List<FolderEntity>>> call(
    GetQueryParams params,
  ) async {
    try {
      final data = await audioQueryRepository.getAllFolders(
        refetch: params.refetch ?? false,
      );
      return data.fold(
        (l) => Left(l),
        (r) async {
          final List<FolderHiveModel> convertedHiveFolders = r
              .map(
                (e) => FolderHiveModel.fromMap(
                  e.toMap(),
                ),
              )
              .toList();
          await queryHiveService.addFolders(convertedHiveFolders);
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
