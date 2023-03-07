import 'package:flutter/material.dart';
import 'package:musync/ui/music/provider/music_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MusicListPage extends StatefulWidget {
  final String directory;

  const MusicListPage({Key? key, this.directory = ''}) : super(key: key);

  @override
  State<MusicListPage> createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final int _pageSize = 100;
  List<String>? _files;
  int _currentPage = 0;
  bool _isLoading = false;
  bool _allLoaded = false;

  @override
  void initState() {
    super.initState();
    _fetchFiles(_currentPage);
    requestPermission();
  }

  void requestPermission() async {
    if (!kIsWeb) {
      final bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      setState(() {});
    }
  }

  Future<void> _fetchFiles(int page) async {
    setState(() {
      _isLoading = true;
    });

    final List<String> files = widget.directory.isNotEmpty
        ? await MusicProvider().getFolderMusic(widget.directory)
        : await MusicProvider().getAllMusic();

    final int start = page * _pageSize;
    int end = (page + 1) * _pageSize;
    end = end > files.length ? files.length : end;

    setState(() {
      _files ??= files.sublist(start, end);
      _files!.addAll(files.sublist(start, end));
      _allLoaded = end == files.length;
      _currentPage = page;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MP3 and ACC Files'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    if (_files == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (_files!.isEmpty) {
      return const Center(
        child: Text('No files found'),
      );
    } else {
      return NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (!_allLoaded &&
              scrollNotification is ScrollEndNotification &&
              scrollNotification.metrics.extentAfter == 0) {
            _fetchFiles(_currentPage + 1);
          }
          return true;
        },
        child: FutureBuilder<List<SongModel>>(
          future: _audioQuery.querySongs(
            sortType: null,
            path: widget.directory,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true,
          ),
          builder: (context, item) {
            if (item.data == null) {
              return const CircularProgressIndicator();
            } else if (item.data!.isEmpty) {
              return const Text("Nothing found!");
            } else {
              return ListView.builder(
                itemCount: item.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(item.data![index].title),
                    subtitle: Text(item.data![index].artist ?? "No Artist"),
                    trailing: const Icon(Icons.arrow_forward_rounded),
                    leading: QueryArtworkWidget(
                      id: item.data![index].id,
                      type: ArtworkType.AUDIO,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/music_player',
                          arguments: item.data![index]);
                    },
                  );
                },
              );
            }
          },
        ),
      );
    }
  }
}
