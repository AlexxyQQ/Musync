import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/common/custom_widgets/custom_form_filed.dart';
import 'package:musync/core/common/song_list_tile.dart';
import 'package:musync/core/utils/extensions/app_text_theme_extension.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/presentation/cubit/home_state.dart';
import 'package:musync/features/home/presentation/cubit/query_cubit.dart';

class SongsListPage extends StatefulWidget {
  final List<SongEntity> songs;
  const SongsListPage({
    super.key,
    required this.songs,
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
    // Retrieves the current state from QueryCubit
    final HomeState state = BlocProvider.of<QueryCubit>(context).state;

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

  @override
  Widget build(BuildContext context) {
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
            fillColor: AppColors().surfaceContainer,
          ),
        ),
        leadingWidth: MediaQuery.of(context).size.width,
        toolbarHeight: 80.h,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.h),
        child: _buildSongList(isSearching ? searchedSongs : widget.songs),
      ),
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
  Widget _buildSongList(List<SongEntity> songs) {
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
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final song = songs[index];
        return SongListTile(
          song: song,
          trailing: true,
        );
      },
      itemCount: songs.length,
    );
  }
}
