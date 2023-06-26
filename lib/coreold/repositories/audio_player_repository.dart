import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
// import 'package:just_audio_background/just_audio_background.dart';

class AudioPlayerRepository {
  final AudioPlayer audioPlayer;
  List<SongModel> _songs = [];

  AudioPlayerRepository({required this.audioPlayer});

  Future<void> playSpecificSong(String path) async {
    await audioPlayer.setFilePath(path);
    await audioPlayer.play();
  }

  Future<void> playAll(List<SongModel> songs, int index) async {
    try {
      _songs = songs;
      final String tempPath = await path_provider
          .getTemporaryDirectory()
          .then((value) => value.path);
      await audioPlayer.setAudioSource(
        ConcatenatingAudioSource(
          children: songs.map(
            (song) {
              return AudioSource.uri(
                Uri.parse(song.data),
                // tag: MediaItem(
                //   id: "${song.id}",
                //   artist: song.artist,
                //   title: song.title,
                //   artHeaders: {
                //     "User-Agent":
                //         "Mozilla/5.0 (Linux; Android 10; SM-A205U) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Mobile Safari/537.36"
                //   },
                //   artUri: Uri.parse(
                //       'File://$tempPath/${song.displayNameWOExt}.png'),
                // ),
              );
            },
          ).toList(),
        ),
        initialIndex: index,
      );

      await audioPlayer.play();
    } catch (e) {
      // print(e.toString());
    }
  }

  // Getters
  AudioPlayer get player => audioPlayer;
  List<SongModel> get songs => _songs;
}
