import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

abstract class INowPlayingRepository {
  Future<Either<ErrorModel, void>> playAll({
    required List<SongEntity> songs,
    required int index,
  });
}
