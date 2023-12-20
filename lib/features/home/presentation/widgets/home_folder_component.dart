import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/features/home/domain/entity/folder_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class HomeFolderComponent extends StatefulWidget {
  final List<FolderEntity> folders;
  const HomeFolderComponent({
    super.key,
    required this.folders,
  });

  @override
  State<HomeFolderComponent> createState() => _HomeFolderComponentState();
}

class _HomeFolderComponentState extends State<HomeFolderComponent> {
  List<FolderEntity> get _folders {
    int numberOfFolders = min(widget.folders.length, 8); // Max 8 folders
    numberOfFolders -= numberOfFolders % 2; // Ensure even number
    return widget.folders.sublist(0, numberOfFolders);
  }

  List<List<String>> getAlbumCovers() {
    List<List<String>> albumCoversPerFolder = [];
    List<FolderEntity> selectedFolders = _folders;

    for (FolderEntity folder in selectedFolders) {
      List<SongEntity> songs = folder.songs ?? [];

      List<String> albumCovers = [];
      for (int i = 0; i < 4; i++) {
        // Always pick 4 covers
        albumCovers.add(
          songs[i % songs.length].albumArt ?? '',
        ); // Loop over songs if fewer than 4
      }

      albumCoversPerFolder.add(albumCovers);
    }

    return albumCoversPerFolder;
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> albumCoversPerFolder =
        getAlbumCovers(); // Retrieve album covers
    return Column(
      children: [
        // Section Title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Folders',
            ),
            IconButton(
              onPressed: () {
                // TODO: Go to all folders page
              },
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
              ),
            ),
          ],
        ),
        // Grid Section
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: List.generate(_folders.length, (index) {
            return FolderComponent(
              folderName: _folders[index].folderName,
              network: false,
              coverImageUrls:
                  albumCoversPerFolder[index], // Pass the correct album covers
            );
          }),
        ),
      ],
    );
  }
}

class FolderComponent extends StatelessWidget {
  final String folderName;
  final List<String> coverImageUrls;
  final bool network;
  const FolderComponent({
    super.key,
    required this.folderName,
    required this.coverImageUrls,
    required this.network,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 100.w,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[300],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: FolderCoverCollage(
              coverImageUrls: coverImageUrls,
              network: network,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 110,
            child: Text(
              folderName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FolderCoverCollage extends StatelessWidget {
  final List<String> coverImageUrls;
  final bool network;
  const FolderCoverCollage({
    super.key,
    required this.coverImageUrls,
    required this.network,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1,
      crossAxisCount: 2, // 2 items per row
      crossAxisSpacing: 0, // No space between items horizontally
      mainAxisSpacing: 0, // No space between items vertically
      padding: EdgeInsets.zero, // No padding around the grid
      children: List.generate(4, (index) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.green,
          ),
          child: network
              ? CachedNetworkImage(
                  imageUrl: coverImageUrls[index],
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Image.file(
                  File(coverImageUrls[index]),
                  fit: BoxFit.cover,
                ),
        );
      }),
    );
  }
}
