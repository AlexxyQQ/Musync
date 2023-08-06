import 'package:audio_service/audio_service.dart';
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
                  tag: MediaItem(
                    extras: song.toMap(),
                    id: "${song.id}",
                    artist: song.artist,
                    title: song.title,
                    artHeaders: {
                      "User-Agent":
                          "Mozilla/5.0 (Linux; Android 10; SM-A205U) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Mobile Safari/537.36"
                    },
                    artUri: Uri.parse("File:/${song.albumArt}"),
                    displayTitle: song.displayName,
                    duration: Duration(milliseconds: song.duration!),
                  ),
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

  // Play single song
  Future<Either<ErrorModel, void>> playSingle({
    required SongEntity song,
  }) async {
    try {
      await audioQuery.setAudioSource(
        AudioSource.uri(
          Uri.parse(song.data),
          tag: song,
        ),
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
