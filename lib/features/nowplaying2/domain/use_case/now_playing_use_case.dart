import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/nowplaying2/data/repository/now_playing_repositories.dart';

class NowPlayingUseCase {
  final NowPlayignRepositiryImpl nowPlayingRepository;

  NowPlayingUseCase(this.nowPlayingRepository);

  Future<void> playAll({
    required List<SongEntity> songs,
    required int index,
  }) async {
    await nowPlayingRepository.playAll(
      songs: songs,
      index: index,
    );
  }
}
