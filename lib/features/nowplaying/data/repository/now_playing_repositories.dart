import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/utils/connectivity_check.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/nowplaying/data/data_source/now_playing_local_data_source.dart';
import 'package:musync/features/nowplaying/data/data_source/now_playing_remote_data_source.dart';
import 'package:musync/features/nowplaying/domain/repository/now_playing_repository_a.dart';

class NowPlayignRepositiryImpl extends INowPlayingRepository {
  final NowPlayingLocalDataSource nowPlayingLocalDataSource;
  final NowPlayingRemoteDataSource nowPlayingRemoteDataSource;

  NowPlayignRepositiryImpl(
    this.nowPlayingLocalDataSource,
    this.nowPlayingRemoteDataSource,
  );

  @override
  Future<Either<ErrorModel, void>> playAll({
    required List<SongEntity> songs,
    required int index,
  }) async {
    final isConnected = await ConnectivityCheck.connectivity();
    final isServerUp = await ConnectivityCheck.isServerup();

    try {
      if (isConnected && isServerUp) {
        return nowPlayingRemoteDataSource.playAll(
          songs: songs,
          index: index,
        );
      } else {
        return nowPlayingLocalDataSource.playAll(
          songs: songs,
          index: index,
        );
      }
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
