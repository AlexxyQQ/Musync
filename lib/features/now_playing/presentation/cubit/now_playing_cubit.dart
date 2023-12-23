import 'package:musync/core/common/exports.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/now_playing/presentation/cubit/now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  NowPlayingCubit() : super(NowPlayingState.initial());

  void setCurrentSong(SongEntity song) {
    emit(
      state.copyWith(
        currentSong: song,
      ),
    );
  }
}
