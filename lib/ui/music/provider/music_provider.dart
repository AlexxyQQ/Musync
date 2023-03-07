import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MusicProvider extends ChangeNotifier {
  List<Directory> _musicDirectories = [];
  List<String>? _allMusicFiles;

  Future<List<Directory>> getMusicDirectories() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Directory> musicDirectoriesCache = prefs
            .getStringList('musicDirectoriesCache')
            ?.map((path) => Directory(path))
            .toList(growable: false) ??
        [];

    if (_musicDirectories.isNotEmpty) {
      return _musicDirectories;
    } else if (musicDirectoriesCache.isNotEmpty) {
      _musicDirectories = musicDirectoriesCache;
      return _musicDirectories;
    }

    final defaultDirectories = [
      Directory("/storage/emulated/0/Download"),
      Directory("/storage/emulated/0/Music"),
      Directory(
          "${(await getExternalStorageDirectories())?.last.path.split('/').sublist(0, 3).join('/')}/Download"),
      Directory(
          "${(await getExternalStorageDirectories())?.last.path.split('/').sublist(0, 3).join('/')}/Music"),
    ];

    List<Directory> currentDirectories = List.of(defaultDirectories);

    while (currentDirectories.isNotEmpty) {
      List<Directory> newDirectories = [];

      for (final directory in currentDirectories) {
        final files = directory.listSync(recursive: false, followLinks: true);

        if (files.any((file) => file is Directory)) {
          newDirectories.addAll(files.whereType<Directory>());
        }

        if (files.any((file) =>
            file.path.endsWith('.mp3') || file.path.endsWith('.acc'))) {
          _musicDirectories.add(directory);
        }
      }

      currentDirectories = newDirectories;
    }

    prefs.setStringList(
        'musicDirectoriesCache',
        _musicDirectories
            .map((directory) => directory.path)
            .toList(growable: false));

    return _musicDirectories;
  }

  Future<List<String>> getFolderMusic(String dir) async {
    final directory = Directory(dir);

    if (!await directory.exists()) {
      return [];
    }

    final prefs = await SharedPreferences.getInstance();
    final List<String> allMusicPathCache =
        prefs.getStringList('allMusicPathCache') ?? [];

    final List<String> musicFiles = [];

    for (final cachePath in allMusicPathCache) {
      if (cachePath.startsWith(dir)) {
        musicFiles.add(cachePath);
      }
    }

    return musicFiles;
  }

  Future<List<String>> getAllMusic() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Directory> allMusicPathCache = prefs
            .getStringList('allMusicPathCache')
            ?.map((path) => Directory(path))
            .toList(growable: false) ??
        [];
    if (_allMusicFiles != null) {
      return _allMusicFiles!;
    }

    if (allMusicPathCache.isNotEmpty) {
      _allMusicFiles = allMusicPathCache
          .map((directory) => directory.path)
          .toList(growable: false);
      return _allMusicFiles!;
    }

    List<String> musicFiles = [];

    List<Directory> defaultDirectories = await getMusicDirectories();

    for (final directory in defaultDirectories) {
      if (await directory.exists()) {
        final files = await directory.list().toList();
        for (final file in files) {
          if (file.path.endsWith('.mp3') || file.path.endsWith('.acc')) {
            musicFiles.add(file.path);
          }
        }
      }
    }

    _allMusicFiles = musicFiles.toList();
    prefs.setStringList('allMusicPathCache', _allMusicFiles!);
    return _allMusicFiles!;
  }
}
