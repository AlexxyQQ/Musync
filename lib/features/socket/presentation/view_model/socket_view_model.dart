
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/core/utils/connectivity_check.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/nowplaying/domain/use_case/now_playing_use_case.dart';
import 'package:musync/features/nowplaying/presentation/view_model/now_playing_view_model.dart';
import 'package:musync/features/socket/presentation/state/state.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketCubit extends Cubit<SocketState> {
  late io.Socket _socket;
  final NowPlayingUseCase nowPlayingUseCase;

  SocketCubit(
    this.nowPlayingUseCase,
  ) : super(SocketState.initial());

  // socketStream getter

  Stream<io.Socket> get socketStream async* {
    yield _socket;
  }

  void initSocket({
    required UserEntity? loggedUser,
    required String? model,
  }) {
    if (loggedUser != null || model != '') {
      emit(state.copyWith(
        loggedUser: loggedUser,
        model: model,
      ),);

      final socketOptions =
          io.OptionBuilder().setTransports(['websocket']).setQuery({
        'userEmail': loggedUser!.email,
        'uid': model,
      }).build();

      if (loggedUser.email != "Guest") {
        // Disable force new connection
        socketOptions['forceNew'] = false;
      } else {
        // Enable force new connection
        socketOptions['forceNew'] = true;
      }

      _socket = io.io('http://192.168.1.65:3002', socketOptions);
    }
  }

  Future<void> onConnect() async {
    _socket.connect();
    _socket.onConnect((data) {
      _socket.emit('connection', {
        'userEmail': state.loggedUser!.email,
        'uid': state.model,
      });
    });
    _socket.onDisconnect((_) => print('Disconnected from server'));
  }

// on disconnect

  Future<void> disconnect() async {
    _socket.disconnect();
  }

  // on share
  Future<void> onShare({
    required List<SongEntity> songList,
    required int songIndex,
  }) async {
    await ConnectivityCheck.isServerup()
        ? _socket.emit('shared', {
            'songList': songList.map((song) => song.toApiMap()).toList(),
            'songIndex': songIndex,
            'playing': true,
          })
        : null;
  }

  // on recieved share
  Future<void> onRecievedShare({required BuildContext context}) async {
    _socket.on('shared-song', (data) async {
      emit(
        state.copyWith(
          queue: List<SongEntity>.from(
            data['songList']
                .map((song) => SongEntity.fromApiMap(song))
                .toList(),
          ),
          index: data['songIndex'],
        ),
      );
      final nowPlayingState =
          BlocProvider.of<NowPlayingViewModel>(context).state;
      final nowPlayingViewModel = BlocProvider.of<NowPlayingViewModel>(context);

      nowPlayingViewModel.emit(nowPlayingState.copyWith(isLoading: true));
      nowPlayingViewModel.playAll(
        songs: List<SongEntity>.from(
          data['songList'].map((song) => SongEntity.fromApiMap(song)).toList(),
        ),
        index: data['songIndex'],
      );

      nowPlayingViewModel.emit(
        nowPlayingState.copyWith(
          isLoading: false,
          isPlaying: true,
          isPaused: false,
          isStopped: false,
          currentSong: state.queue[data['songIndex']],
          queue: state.queue,
          currentIndex: state.index!,
        ),
      );
    });
  }

  void dispose() {
    _socket.disconnect();
  }
}
