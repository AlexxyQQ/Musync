import 'package:dartz/dartz.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class NowPlayingLocalDataSource {
  final AudioPlayer audioQuery;

  NowPlayingLocalDataSource(this.audioQuery);

  Future<Either<ErrorModel, void>> playAll({
    required List<SongEntity> songs,
    required int index,
  }) async {
    try {
      await audioQuery.setAudioSource(
        ConcatenatingAudioSource(
          children: songs
              .map(
                (song) => AudioSource.uri(
                  Uri.parse(song.data),
                  tag: song,
                ),
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
