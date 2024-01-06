import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/usecase/usecase.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/domain/repository/audio_query_repository.dart';

class UpdateSongUsecase extends UseCase<String, SongEntity> {
  final IAudioQueryRepository audioQueryRepository;

  UpdateSongUsecase({
    required this.audioQueryRepository,
  });

  @override
  Future<Either<AppErrorHandler, String>> call(SongEntity params) async {
    return await audioQueryRepository.updateSong(
      song: params,
    );
  }
}
