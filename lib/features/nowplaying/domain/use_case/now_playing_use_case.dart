import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musync/config/constants/api_endpoints.dart';
import 'package:musync/core/utils/connectivity_check.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/nowplaying/data/repository/now_playing_repositories.dart';

class NowPlayingUseCase {
  final NowPlayignRepositiryImpl nowPlayingRepository;

  NowPlayingUseCase(this.nowPlayingRepository);

  Future<void> playAll({
    required List<SongEntity> songs,
    required int index,
  }) async {
    // final isConnected = await ConnectivityCheck.connectivity();
    // final isServerUp = await ConnectivityCheck.isServerup();
    // try {
    //   if (isConnected && isServerUp) {
    //     await GetIt.instance<AudioPlayer>().setAudioSource(
    //       ConcatenatingAudioSource(
    //         children: songs
    //             .map(
    //               (song) => (song.serverUrl == '' || song.serverUrl == null)
    //                   ? AudioSource.uri(
    //                       Uri.parse(song.data),
    //                       tag: song,
    //                     )
    //                   : AudioSource.uri(
    //                       Uri.parse(
    //                         '${ApiEndpoints.baseImageUrl}${song.serverUrl}',
    //                       ),
    //                       tag: song,
    //                     ),
    //             )
    //             .toList(),
    //       ),
    //       initialIndex: index,
    //     );

    //     await GetIt.instance<AudioPlayer>().play();
    //   } else {
    //     await GetIt.instance<AudioPlayer>().setAudioSource(
    //       ConcatenatingAudioSource(
    //         children: songs
    //             .map(
    //               (song) => AudioSource.uri(
    //                 Uri.parse(song.data),
    //                 tag: song,
    //               ),
    //             )
    //             .toList(),
    //       ),
    //       initialIndex: index,
    //     );
    //     await GetIt.instance<AudioPlayer>().play();
    //   }
    // } catch (e) {}

    await nowPlayingRepository.playAll(
      songs: songs,
      index: index,
    );
  }
}
