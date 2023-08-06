import 'package:dartz/dartz.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musync/config/constants/api_endpoints.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class NowPlayingRemoteDataSource {
  final AudioPlayer audioQuery;

  NowPlayingRemoteDataSource(this.audioQuery);

  // Play All Songs
  Future<Either<ErrorModel, void>> playAll({
    required List<SongEntity> songs,
    required int index,
  }) async {
    try {
      // check if the serverUrl is null
      await audioQuery.setAudioSource(
        ConcatenatingAudioSource(
          children: songs
              .map(
                (song) => (song.serverUrl == '' || song.serverUrl == null)
                    ? AudioSource.uri(Uri.parse(song.data), tag: song)
                    : AudioSource.uri(
                        Uri.parse(
                          '${ApiEndpoints.baseImageUrl}${song.serverUrl}',
                        ),
                        tag: song),
              )
              .toList(),
        ),
        initialIndex: index,
      );

      await audioQuery.play();
      return const Right(null);
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
