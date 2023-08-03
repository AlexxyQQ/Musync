// Define the state
import 'package:musync/features/nowplaying/presentation/state/now_playing_state.dart';
import 'package:musync/features/socket/presentation/state/state.dart';

class MultiState {
  final NowPlayingState nowPlayingState;
  final SocketState socketState;

  MultiState(this.nowPlayingState, this.socketState);

  factory MultiState.initial() {
    return MultiState(NowPlayingState.initial(), SocketState.initial());
  }
}
