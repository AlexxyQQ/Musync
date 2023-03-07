import 'package:flutter/material.dart';
import 'package:musync/ui/music/provider/music_provider.dart';

class MusicListPage extends StatefulWidget {
  final String directory;

  const MusicListPage({Key? key, this.directory = ''}) : super(key: key);

  @override
  State<MusicListPage> createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  final int _pageSize = 100;
  List<String>? _files;
  int _currentPage = 0;
  bool _isLoading = false;
  bool _allLoaded = false;

  @override
  void initState() {
    super.initState();
    _fetchFiles(_currentPage);
  }

  Future<void> _fetchFiles(int page) async {
    setState(() {
      _isLoading = true;
    });

    List<String> files = [];
    if (widget.directory.isNotEmpty) {
      files = await MusicProvider().getFolderMusic(widget.directory);
    } else {
      files = await MusicProvider().getAllMusic();
    }

    int start = page * _pageSize;
    int end = (page + 1) * _pageSize;
    if (end > files.length) {
      end = files.length;
    }

    setState(() {
      if (_files == null) {
        _files = files.sublist(start, end);
      } else {
        _files!.addAll(files.sublist(start, end));
      }

      if (end == files.length) {
        _allLoaded = true;
      }

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
      body: _files == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _files!.isEmpty
              ? const Center(
                  child: Text('No files found'),
                )
              : NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (!_allLoaded &&
                        scrollNotification is ScrollEndNotification &&
                        scrollNotification.metrics.extentAfter == 0) {
                      _fetchFiles(_currentPage + 1);
                    }
                    return true;
                  },
                  child: ListView.separated(
                    itemCount: _files!.length + (_allLoaded ? 0 : 1),
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == _files!.length) {
                        if (_isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      } else {
                        return ListTile(
                          title: Text(
                            _files![index],
                          ),
                        );
                      }
                    },
                  ),
                ),
    );
  }
}
