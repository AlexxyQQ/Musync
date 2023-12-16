// import 'dart:math';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:musync/features/home/domain/entity/folder_entity.dart';
// import 'package:musync/features/home/domain/entity/song_entity.dart';

// class HomeFolderComponent extends StatefulWidget {
//   final List<FolderEntity> folders;
//   const HomeFolderComponent({
//     super.key,
//     required this.folders,
//   });

//   @override
//   State<HomeFolderComponent> createState() => _HomeFolderComponentState();
// }

// class _HomeFolderComponentState extends State<HomeFolderComponent> {
//   // // Select random 2,4,6 or 8 folders to display according to the number of folders
//   // List<FolderEntity> get _randomFolders {
//   //   final random = Random();
//   //   // Generate a number from 1 to 4, then multiply by 2 to get 2, 4, 6, or 8
//   //   final numberOfFolders = (random.nextInt(4) + 1) * 2;
//   //   // Ensure we do not exceed the list's length
//   //   final sublistSize = min(numberOfFolders, widget.folders.length);
//   //   // Shuffle the list to ensure randomness
//   //   final List<FolderEntity> shuffledFolders =
//   //       List<FolderEntity>.from(widget.folders)..shuffle();
//   //   // Return a sublist containing the random number of folders
//   //   return shuffledFolders.sublist(0, sublistSize);
//   // }

//   List<List<String>> getAlbumCovers() {
//     List<List<String>> albumCoversPerFolder = [];
//     List<FolderEntity> randomFolders = _randomFolders;

//     for (FolderEntity folder in randomFolders) {
//       List<SongEntity> songs = folder.songs ?? [];

//       int numberOfCovers = songs.length >= 4 ? 4 : 1;

//       songs.shuffle(); // Randomize the songs list
//       List<String> albumCovers = songs
//           .take(numberOfCovers) // Take the first 4 or 1 if less
//           .map(
//             (song) => song.albumArt,
//           ) // Assuming each song has an albumCover property
//           .toList();

//       albumCoversPerFolder.add(albumCovers);
//     }

//     return albumCoversPerFolder;
//   }

//   List<FolderEntity> get _randomFolders {
//     final random = Random();
//     final numberOfFolders = (random.nextInt(4) + 1) * 2;
//     final sublistSize = min(numberOfFolders, widget.folders.length);
//     final List<FolderEntity> shuffledFolders =
//         List<FolderEntity>.from(widget.folders)..shuffle();
//     return shuffledFolders.sublist(0, sublistSize);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Section Title
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Folders',
//             ),
//             IconButton(
//               onPressed: () {
//                 // TODO: Go to all folders page
//               },
//               icon: const Icon(
//                 Icons.arrow_forward_ios_rounded,
//                 size: 16,
//               ),
//             ),
//           ],
//         ),
//         // Grid Section
//         GridView.count(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           crossAxisCount: 2,
//           childAspectRatio: 3,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           children: _randomFolders
//               .map((e) => FolderComponent(
//                     folderName: e.folderName,
//                     coverImageUrls: ,
//                   ))
//               .toList(),
//         ),
//       ],
//     );
//   }
// }

// class FolderComponent extends StatelessWidget {
//   final String folderName;
//   final List<String> coverImageUrls;
//   const FolderComponent({
//     super.key,
//     required this.folderName,
//     required this.coverImageUrls,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60.h,
//       width: 100.w,
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: Colors.grey[300],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 40,
//             height: 40,
//             child: FolderCoverCollage(
//               coverImageUrls: coverImageUrls,
//             ),
//           ),
//           const SizedBox(width: 8),
//           Text(
//             folderName,
//             style: const TextStyle(
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FolderCoverCollage extends StatelessWidget {
//   final List<String> coverImageUrls;
//   const FolderCoverCollage({super.key, required this.coverImageUrls});

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       childAspectRatio: 1,
//       crossAxisCount: 2, // 2 items per row
//       crossAxisSpacing: 0, // No space between items horizontally
//       mainAxisSpacing: 0, // No space between items vertically
//       padding: EdgeInsets.zero, // No padding around the grid
//       children: List.generate(4, (index) {
//         return Container(
//           decoration: const BoxDecoration(
//             color: Colors.green,
//           ),
//           child: CachedNetworkImage(
//             imageUrl: coverImageUrls[index],
//             fit: BoxFit.cover,
//             errorWidget: (context, url, error) => const Icon(Icons.error),
//             placeholder: (context, url) => const Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
