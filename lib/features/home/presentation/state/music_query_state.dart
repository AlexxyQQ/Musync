import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:musync/features/home/domain/entity/playlist_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class MusicQueryState {
  final Map<String, List<SongEntity>> albumWithSongs;
  final List<AlbumEntity> albums;
  final Map<String, List<SongEntity>> artistWithSongs;
  final Map<String, List<SongEntity>> folderWithSongs;
  final List<String> folders;
  final List<SongEntity> songs;
  final List<SongEntity> folderSongs;
  final bool permission;
  final Map<String, Map<String, List<SongEntity>>> everything;
  final List<PlaylistEntity> playlists;
  final bool createPlaylist;
  final bool addAllSongs;

  final String? error;
  final bool isLoading;
  final bool isUploading;
  MusicQueryState({
    required this.albumWithSongs,
    required this.albums,
    required this.artistWithSongs,
    required this.folderWithSongs,
    required this.folders,
    required this.songs,
    required this.folderSongs,
    required this.permission,
    required this.everything,
    required this.playlists,
    required this.createPlaylist,
    required this.addAllSongs,
    this.error,
    required this.isLoading,
    required this.isUploading,
  });

  factory MusicQueryState.initial() {
    return MusicQueryState(
      albumWithSongs: {},
      albums: [],
      artistWithSongs: {},
      folderWithSongs: {},
      folders: [],
      songs: [],
      folderSongs: [],
      permission: false,
      everything: {},
      playlists: [],
      createPlaylist: false,
      addAllSongs: false,
      error: null,
      isLoading: false,
      isUploading: false,
    );
  }

  MusicQueryState copyWith({
    Map<String, List<SongEntity>>? albumWithSongs,
    List<AlbumEntity>? albums,
    Map<String, List<SongEntity>>? artistWithSongs,
    Map<String, List<SongEntity>>? folderWithSongs,
    List<String>? folders,
    List<SongEntity>? songs,
    List<SongEntity>? folderSongs,
    bool? permission,
    Map<String, Map<String, List<SongEntity>>>? everything,
    List<PlaylistEntity>? playlists,
    bool? createPlaylist,
    bool? addAllSongs,
    String? error,
    bool? isLoading,
    bool? isUploading,
  }) {
    return MusicQueryState(
      albumWithSongs: albumWithSongs ?? this.albumWithSongs,
      albums: albums ?? this.albums,
      artistWithSongs: artistWithSongs ?? this.artistWithSongs,
      folderWithSongs: folderWithSongs ?? this.folderWithSongs,
      folders: folders ?? this.folders,
      songs: songs ?? this.songs,
      folderSongs: folderSongs ?? this.folderSongs,
      permission: permission ?? this.permission,
      everything: everything ?? this.everything,
      playlists: playlists ?? this.playlists,
      createPlaylist: createPlaylist ?? this.createPlaylist,
      addAllSongs: addAllSongs ?? this.addAllSongs,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isUploading: isUploading ?? this.isUploading,
    );
  }
}
