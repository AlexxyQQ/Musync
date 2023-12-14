// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:musync/features/home/domain/entity/artist_entity.dart';
// import 'package:musync/features/home/domain/entity/folder_entity.dart';
// import 'package:musync/features/home/domain/entity/song_entity.dart';
// import 'package:musync/features/home/presentation/cubit/home_state.dart';
// import 'package:musync/features/home/presentation/cubit/query_cubit.dart';

// import '../../domain/entity/album_entity.dart';

// class MusicScreen extends StatelessWidget {
//   const MusicScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<QueryCubit, HomeState>(
//       builder: (context, state) {

//         if (state.isLoading) {
//           return Scaffold(
//             body: Center(child: Text('Songs Loaded: ${state.count}')),
//           );
//         } else if (state.isSuccess) {
//           log('Songs Loaded: ${state.albums?[0].songs?.toString()}');
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Music'),
//               actions: [
//                 IconButton(
//                   onPressed: () {
//                     BlocProvider.of<QueryCubit>(context).init();
//                   },
//                   icon: const Icon(
//                     Icons.refresh,
//                   ),
//                 ),
//               ],
//             ),
//             body: PageView.builder(
//               itemCount: 4,
//               itemBuilder: (context, index) {
//                 var list = [
//                   albumPage(context, state.albums ?? []),
//                   artistPage(context, state.artists ?? []),
//                   folderPage(context, state.folders ?? []),
//                   songsPage(context, state.songs ?? []),
//                 ];
//                 return list[index];
//               },
//             ),
//           );
//         } else if (state.error != null) {
//           return Scaffold(
//             body: Center(child: Text('Error: ${state.error!.message}')),
//           );
//         }
//         return Container();
//       },
//     );
//   }
// }

// albumPage(BuildContext context, List<AlbumEntity> albums) {
//   return ListView.builder(
//     itemCount: albums.length,
//     itemBuilder: (context, index) {
//       final album = albums[index];
//       return InkWell(
//         onTap: () {
//           // Show a modal bottom sheet when the widget is tapped.
//           showModalBottomSheet<void>(
//             context: context,
//             builder: (BuildContext context) {
//               return ListView.builder(
//                 itemCount: album.songs?.length ?? 0,
//                 itemBuilder: (context, indexw) {
//                   final song = album.songs?[indexw];
//                   return ListTile(
//                     title: Text(
//                       song?.title ?? '',
//                     ),
//                     subtitle: Text(
//                       "${song?.artist}",
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//         child: ListTile(
//           title: Text(album.album),
//           subtitle: Text("${album.numOfSongs}"),
//         ),
//       );
//     },
//   );
// }

// artistPage(BuildContext context, List<ArtistEntity> artits) {
//   return ListView.builder(
//     itemCount: artits.length,
//     itemBuilder: (context, index) {
//       final artist = artits[index];
//       return InkWell(
//         onTap: () {
//           // Show a modal bottom sheet when the widget is tapped.
//           showModalBottomSheet<void>(
//             context: context,
//             builder: (BuildContext context) {
//               return ListView.builder(
//                 itemCount: artits[index].songs?.length ?? 0,
//                 itemBuilder: (context, indexw) {
//                   final song = artist.songs?[indexw];
//                   return ListTile(
//                     title: Text(
//                       song?.title ?? '',
//                     ),
//                     subtitle: Text(
//                       "${song?.artist}",
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//         child: ListTile(
//           title: Text(artist.artist),
//           subtitle: Text("${artist.songs?.length ?? 0}"),
//         ),
//       );
//     },
//   );
// }

// folderPage(BuildContext context, List<FolderEntity> folders) {
//   return ListView.builder(
//     itemCount: folders.length,
//     itemBuilder: (context, index) {
//       final folder = folders[index];
//       return InkWell(
//         onTap: () {
//           // Show a modal bottom sheet when the widget is tapped.
//           showModalBottomSheet<void>(
//             context: context,
//             builder: (BuildContext context) {
//               return ListView.builder(
//                 itemCount: folders[index].songs?.length ?? 0,
//                 itemBuilder: (context, index) {
//                   final song = folder.songs?[index];
//                   return ListTile(
//                     title: Text(
//                       song?.title ?? '',
//                     ),
//                     subtitle: Text(
//                       "${song?.artist}",
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//         child: ListTile(
//           title: Text(folder.folderName),
//           subtitle: Text("${folder.songs?.length ?? 0}"),
//         ),
//       );
//     },
//   );
// }

// songsPage(BuildContext context, List<SongEntity> songs) {
//   return ListView.builder(
//     itemCount: songs.length,
//     itemBuilder: (context, index) {
//       return ListTile(
//         title: Text(songs[index].title),
//         subtitle: Text("${songs[index].artist}"),
//       );
//     },
//   );
// }

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [Placeholder()],
          ),
        ),
      ),
    );
  }
}
