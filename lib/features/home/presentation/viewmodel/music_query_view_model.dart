import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/domain/use_case/music_query_use_case.dart';
import 'package:musync/features/home/presentation/state/music_query_state.dart';

class MusicQueryCubit extends Cubit<MusicQueryState> {
  final MusicQueryUseCase _musicQueryUseCase;

  MusicQueryCubit(this._musicQueryUseCase) : super(MusicQueryState.initial()) {}

  Future<void> getAllAlbumWithSongs() async {
    emit(state.copyWith(isLoading: true));
    final data = await _musicQueryUseCase.getAllAlbumWithSongs();
    data.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.message)),
      (r) => emit(
        state.copyWith(
          isLoading: false,
          albumWithSongs: r,
        ),
      ),
    );
  }

  Future<void> getAllAlbums() async {
    emit(state.copyWith(isLoading: true));
    final data = await _musicQueryUseCase.getAllAlbums();
    data.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.message)),
      (r) => emit(
        state.copyWith(
          isLoading: false,
          albums: r,
        ),
      ),
    );
  }

  Future<void> getAllArtistWithSongs() async {
    emit(state.copyWith(isLoading: true));
    final data = await _musicQueryUseCase.getAllArtistWithSongs();
    data.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.message)),
      (r) => emit(
        state.copyWith(
          isLoading: false,
          artistWithSongs: r,
        ),
      ),
    );
  }

  Future<void> getAllFolderWithSongs() async {
    emit(state.copyWith(isLoading: true));
    final data = await _musicQueryUseCase.getAllFolderWithSongs();
    data.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.message)),
      (r) => emit(
        state.copyWith(
          isLoading: false,
          folderWithSongs: r,
        ),
      ),
    );
  }

  Future<void> getAllFolders() async {
    emit(state.copyWith(isLoading: true));
    final data = await _musicQueryUseCase.getAllFolders();
    data.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.message)),
      (r) => emit(
        state.copyWith(
          isLoading: false,
          folders: r,
        ),
      ),
    );
  }

  Future<void> getAllSongs() async {
    emit(state.copyWith(isLoading: true));
    final data = await _musicQueryUseCase.getAllSongs();
    data.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.message)),
      (r) => emit(
        state.copyWith(
          isLoading: false,
          songs: r,
        ),
      ),
    );
  }

  Future<void> addAllSongs({
    required List<SongEntity> songs,
    required String token,
  }) async {
    emit(state.copyWith(isUploading: true));
    final data = await _musicQueryUseCase.addAllSongs(
      songs: songs,
      token: token,
    );

    data.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.message)),
      (r) => emit(
        state.copyWith(
          isUploading: false,
          addAllSongs: r,
        ),
      ),
    );
  }

  Future<void> getFolderSongs({
    required String path,
  }) async {
    emit(state.copyWith(isLoading: true));
    final data = await _musicQueryUseCase.getFolderSongs(path: path);
    data.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.message)),
      (r) => emit(
        state.copyWith(
          isLoading: false,
          folderSongs: r,
        ),
      ),
    );
  }

  Future<void> permission() async {
    emit(state.copyWith(isLoading: true));
    final data = await _musicQueryUseCase.permission();
    data.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.message)),
      (r) => emit(
        state.copyWith(
          isLoading: false,
          permission: r,
        ),
      ),
    );
  }

  Future<void> getEverything() async {
    emit(state.copyWith(isLoading: true));
    final data = await _musicQueryUseCase.getEverything();
    data.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.message)),
      (r) => emit(
        state.copyWith(
          isLoading: false,
          everything: r,
        ),
      ),
    );
  }

  Future<void> getAllPlaylists() async {
    emit(state.copyWith(isLoading: true));
    final data = await _musicQueryUseCase.getAllPlaylists();
    data.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.message)),
      (r) => emit(
        state.copyWith(
          isLoading: false,
          playlists: r,
        ),
      ),
    );
  }

  Future<void> createPlaylist({
    required String playlistName,
  }) async {
    emit(state.copyWith(isLoading: true));
    final data = await _musicQueryUseCase.createPlaylist(
      playlistName: playlistName,
    );
    data.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.message)),
      (r) => emit(
        state.copyWith(
          isLoading: false,
          createPlaylist: r,
        ),
      ),
    );
  }
}
