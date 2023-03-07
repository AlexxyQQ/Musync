import 'dart:io';
import 'package:flutter/material.dart';
import 'package:musync/ui/music/pages/music_list_page.dart';
import 'package:musync/ui/music/provider/music_provider.dart';

class MusicFolderPage extends StatefulWidget {
  const MusicFolderPage({Key? key}) : super(key: key);

  @override
  State<MusicFolderPage> createState() => _MusicFolderPageState();
}

class _MusicFolderPageState extends State<MusicFolderPage> {
  late List<Directory> _directories;
  late Future<List<Directory>> _futureDirectories;

  @override
  void initState() {
    super.initState();
    _futureDirectories = _fetchDir();
  }

  Future<List<Directory>> _fetchDir() async {
    final allDir = await MusicProvider().getMusicDirectories();
    return allDir;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Folders'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _futureDirectories = _fetchDir();
          });
        },
        child: FutureBuilder<List<Directory>>(
          future: _futureDirectories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            } else {
              _directories = snapshot.data!;
              return ListView.builder(
                itemCount: _directories.length,
                itemBuilder: (context, index) {
                  final directory = _directories[index];
                  return ListTile(
                    title: Text(directory.path),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            MusicListPage(directory: directory.path),
                      ));
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
