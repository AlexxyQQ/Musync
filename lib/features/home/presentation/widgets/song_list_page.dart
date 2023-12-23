import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/common/custom_widgets/custom_form_filed.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/core/common/song_list_tile.dart';
import 'package:musync/core/utils/extensions/app_text_theme_extension.dart';
import 'package:musync/features/bottom_nav/presentation/widget/mini_player.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/presentation/cubit/query_cubit.dart';
import 'package:musync/features/home/presentation/widgets/method/show_songs_options.dart';
import 'package:musync/features/now_playing/presentation/cubit/now_playing_cubit.dart';

class SongsListPage extends StatefulWidget {
  final List<SongEntity> songs;
  final bool appbar;
  final double coverHeight;
  final double coverWidth;
  final double borderRadius;
  const SongsListPage({
    super.key,
    required this.songs,
    this.appbar = true,
    this.coverHeight = 50,
    this.coverWidth = 50,
    this.borderRadius = 500,
  });

  @override
  State<SongsListPage> createState() => _SongsListPageState();
}

class _SongsListPageState extends State<SongsListPage> {
  /// A TextEditingController for managing the text input for search functionality.
  final TextEditingController _searchController = TextEditingController();

  /// A boolean to check if the user is searching.
  bool isSearching = false;

  /// A list to store SongEntity objects.
  List<SongEntity> searchedSongs = [];

  /// Initializes the state of the widget.
  ///
  /// Sets up a listener on the `_searchController` to filter folders based on user input.
  /// It also initializes the `_folders` list with the current state from `QueryCubit`.
  @override
  void initState() {
    super.initState();

    // Clears the search controller
    _searchController.clear();

    // Adds a listener to the search controller
    _searchController.addListener(() {
      // Calls _filterSongs method whenever the text in the search controller changes
      _filterSongs(query: _searchController.text);
    });

    // Initializes the _folders list with the current folders from the QueryCubit's state
    searchedSongs = widget.songs;
    // Sorts the songs by title
    sortByTitle(ascending: true);
  }

  /// Filters the songs based on the search query.
  ///
  /// When the query is empty, it resets the song list to its original state.
  /// Otherwise, it filters the songs by matching the titles with the query.
  ///
  /// The filtering is case-insensitive.
  ///
  /// [query] The search query used for filtering the songs.
  void _filterSongs({required String query}) {
    // Checks if the search query is empty
    if (query.isEmpty) {
      // If empty, reset the songs to the original list
      searchedSongs = widget.songs;
      // if the search query is empty, set isSearching to false and return
      isSearching = false;
      return;
    }

    // If the search query is not empty, set isSearching to true
    isSearching = true;

    // Filters the songs based on the search query
    searchedSongs = widget.songs.where((song) {
      final songName = song.displayNameWOExt.toLowerCase();
      return songName.contains(query);
    }).toList();

    // Calls setState to update the UI
    setState(() {});
  }

  // Function to sort songs by title
  void sortByTitle({required bool ascending}) {
    searchedSongs.sort((a, b) {
      return ascending
          ? a.displayNameWOExt.compareTo(b.displayNameWOExt)
          : b.displayNameWOExt.compareTo(a.displayNameWOExt);
    });
    setState(() {});
  }

// Function to sort songs by duration
  void sortByDuration({required bool ascending}) {
    searchedSongs.sort((a, b) {
      return ascending
          ? a.duration!.compareTo(b.duration!)
          : b.duration!.compareTo(a.duration!);
    });
    setState(() {});
  }

// Function to sort songs by date added
  void sortByDateAdded({required bool ascending}) {
    searchedSongs.sort((a, b) {
      return ascending
          ? a.dateModified!.compareTo(b.dateModified!)
          : b.dateModified!.compareTo(a.dateModified!);
    });
    setState(() {});
  }

  // Function to show the pop-up menu
  Future<void> _showPopUpOptionMenu(BuildContext context) async {
    final String? selectedValue = await showMenu<String>(
      context: context,
      surfaceTintColor: AppColors().surfaceContainerLow,
      position: RelativeRect.fromLTRB(400.w, 80.h, 10, 0),
      items: [
        PopupMenuItem<String>(
          value: 'title',
          child: Row(
            children: [
              Icon(
                Icons.title,
                color: AppColors().onSurfaceVariant,
                size: 16,
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                'Title',
                style: Theme.of(context).textTheme.mBS.copyWith(
                      color: AppColors().onSurface,
                    ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'duration',
          child: Row(
            children: [
              Icon(
                Icons.timer,
                color: AppColors().onSurfaceVariant,
                size: 16,
              ), // Example icon
              SizedBox(
                width: 4.w,
              ),
              Text(
                'Duration',
                style: Theme.of(context).textTheme.mBS.copyWith(
                      color: AppColors().onSurface,
                    ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'date',
          child: Row(
            children: [
              Icon(
                Icons.date_range,
                color: AppColors().onSurfaceVariant,
                size: 16,
              ), // Example icon
              SizedBox(
                width: 4.w,
              ),
              Text(
                'Date Added',
                style: Theme.of(context).textTheme.mBS.copyWith(
                      color: AppColors().onSurface,
                    ),
              ),
            ],
          ),
        ),
      ],
      // Customizing the popup menu color
      color: AppColors().background,
    );

    // Handle the selection
    if (selectedValue != null) {
      if (selectedValue == 'title') {
        sortByTitle(ascending: true);
      } else if (selectedValue == 'duration') {
        sortByDuration(ascending: true);
      } else if (selectedValue == 'date') {
        sortByDateAdded(ascending: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.appbar
        ? withAppBarandPlayer(
            context,
            widget.coverHeight,
            widget.coverWidth,
            widget.borderRadius,
          )
        : withoutAppBarandPlayer(
            context,
            widget.coverHeight,
            widget.coverWidth,
            widget.borderRadius,
          );
  }

  Scaffold withAppBarandPlayer(
    BuildContext context,
    double? height,
    double? width,
    double? borderRadius,
  ) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
          child: KTextFormField(
            controller: _searchController,
            keyboardType: TextInputType.text,
            hintText: 'Search...........',
            contentStyle: Theme.of(context).textTheme.mBM.copyWith(
                  color: AppColors().onSurface,
                ),
            hintTextStyle: Theme.of(context).textTheme.lBM.copyWith(
                  color: AppColors().onSurfaceVariant,
                ),
            errorTextStyle: Theme.of(context).textTheme.mC.copyWith(
                  color: AppColors().onErrorContainer,
                ),
            prefixIcon: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: AppColors().onSurfaceVariant,
              ),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                _showPopUpOptionMenu(context);
              },
              icon: Icon(
                Icons.filter_list,
                color: AppColors().onSurfaceVariant,
              ),
            ),
            fillColor: AppColors().surfaceContainer,
          ),
        ),
        leadingWidth: MediaQuery.of(context).size.width,
        toolbarHeight: 80.h,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            child: _buildSongList(
              isSearching ? searchedSongs : widget.songs,
              height,
              width,
              borderRadius,
            ),
          ),
          Positioned(
            bottom: 12.w,
            left: 8.w,
            right: 8.w,
            child: const MiniPlayer(),
          ),
        ],
      ),
    );
  }

  Widget withoutAppBarandPlayer(
    BuildContext context,
    double? height,
    double? width,
    double? borderRadius,
  ) {
    return _buildSongList(
      isSearching ? searchedSongs : widget.songs,
      height,
      width,
      borderRadius,
    );
  }

  /// Builds a list of song items.
  ///
  /// This function creates a ListView.builder to display a list of song items.
  /// If the [songs] list is empty, it shows a "No Songs Found" message.
  ///
  /// [songs]: A list of SongEntity objects representing songs.
  ///
  /// Returns a ListView.builder containing song items or a "No Songs Found" message.
  Widget _buildSongList(
    List<SongEntity> songs,
    double? height,
    double? width,
    double? borderRadius,
  ) {
    if (songs.isEmpty) {
      return Center(
        child: Text(
          'No Songs Found',
          style: Theme.of(context).textTheme.mBM.copyWith(
                color: AppColors().onSurface,
              ),
        ),
      );
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        final song = songs[index];
        return GestureDetector(
          onTap: () {
            BlocProvider.of<NowPlayingCubit>(context).setCurrentSong(song);
          },
          child: SongListTile(
            song: song,
            trailing: true,
            coverHeight: height ?? 50.h,
            coverWidth: width ?? 50.w,
            borderRadius: borderRadius ?? 500.r,
            onTap: () {
              songOptions(song, context);
            },
          ),
        );
      },
      itemCount: songs.length,
    );
  }

  // Function to show the bottom sheet

  void deleteFile(String filePath) async {
    try {
      // Check permissions

      var file = File(filePath);

      // Check if file exists
      if (await file.exists()) {
        //  Delete file

        await file.delete();

        print("File deleted successfully");
      } else {
        print("File does not exist");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
