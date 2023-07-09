import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/nowplaying2/data/data_source/now_playing_local_data_source.dart';
import 'package:musync/features/nowplaying2/domain/repository/now_playing_repository_a.dart';

class NowPlayignRepositiryImpl extends INowPlayingRepository {
  final NowPlayingLocalDataSource nowPlayingRemoteDataSource;

  NowPlayignRepositiryImpl(this.nowPlayingRemoteDataSource);
  @override
  Future<Either<ErrorModel, void>> playAll({
    required List<SongEntity> songs,
    required int index,
  }) async {
    try {
      return nowPlayingRemoteDataSource.playAll(
        songs: songs,
        index: index,
      );
    } catch (e) {
      return Left(
        ErrorModel(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }
}
