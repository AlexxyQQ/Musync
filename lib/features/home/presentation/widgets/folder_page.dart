import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/common/custom_widgets/custom_form_filed.dart';
import 'package:musync/core/common/song_list_tile.dart';
import 'package:musync/core/utils/extensions/app_text_theme_extension.dart';
import 'package:musync/features/bottom_nav/presentation/widget/mini_player.dart';
import 'package:musync/features/home/domain/entity/folder_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/presentation/cubit/home_state.dart';
import 'package:musync/features/home/presentation/cubit/query_cubit.dart';
import 'package:musync/features/home/presentation/widgets/folder_song_list_page.dart';

class FolderPage extends StatefulWidget {
  const FolderPage({super.key});

  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  /// A TextEditingController for managing the text input for search functionality.
  final TextEditingController _searchController = TextEditingController();

  /// A list to store FolderEntity objects.
  List<FolderEntity> _folders = [];

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
      // Calls _filterFolder method whenever the text in the search controller changes
      _filterFolder(query: _searchController.text);
    });

    // Initializes the _folders list with the current folders from the QueryCubit's state
    _folders = BlocProvider.of<QueryCubit>(context).state.folders;
  }

  /// Filters the folders based on the search query.
  ///
  /// When the query is empty, it resets the folder list to its original state.
  /// Otherwise, it filters the folders by matching the folder names with the query.
  ///
  /// The filtering is case-insensitive.
  ///
  /// [query] The search query used for filtering the folders.
  void _filterFolder({required String query}) {
    // Retrieves the current state from QueryCubit
    final HomeState state = BlocProvider.of<QueryCubit>(context).state;

    // Checks if the search query is empty
    if (query.isEmpty) {
      // If empty, reset the folders to the original list
      _folders = BlocProvider.of<QueryCubit>(context).state.folders;
      // if the search query is empty, set isSearching to false and return
      isSearching = false;
      return;
    }

    // If the search query is not empty, set isSearching to true
    isSearching = true;

    // Filters the folders based on the search query
    final List<FolderEntity> filteredFolders =
        BlocProvider.of<QueryCubit>(context).state.folders.where((folder) {
      // Converts folder name and search query to lowercase for case-insensitive comparison
      final folderName = folder.folderName.toLowerCase();
      final searchLower = query.toLowerCase();

      // Returns true if the folder name contains the search query
      return folderName.contains(searchLower);
    }).toList();

    // Filters the songs based on the search query
    searchedSongs = state.songs.where((song) {
      final songName = song.displayNameWOExt.toLowerCase();
      return songName.contains(query);
    }).toList();

    // Updates the state with the filtered folders
    // BlocProvider.of<QueryCubit>(context).update(
    //   state.copyWith(
    //     folders: filteredFolders,
    //   ),
    // );

    _folders = filteredFolders;

    // Calls setState to update the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: const MiniPlayer(),
      ),
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
        child: BlocBuilder<QueryCubit, HomeState>(
          builder: (context, state) {
            if (isSearching) {
              /// In a column to display the folders and songs separately and make the folder take the least amount of space
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title for matching folders
                  Text(
                    'Search Results Folders',
                    style: Theme.of(context).textTheme.mBL.copyWith(
                          color: AppColors().onBackground,
                        ),
                  ),
                  // ListView for matching folders
                  ListView.builder(
                    shrinkWrap: true, // Allows the ListView to hug its content
                    itemBuilder: (context, index) {
                      return _buildFolderItem(_folders[index]);
                    },
                    itemCount: _folders.length,
                  ),
                  // Divider
                  Divider(color: AppColors().onSurfaceVariant),
                  SizedBox(height: 12.h),
                  // Title for matching songs
                  Text(
                    'Search Results Songs',
                    style: Theme.of(context).textTheme.mBL.copyWith(
                          color: AppColors().onBackground,
                        ),
                  ),
                  // Flexible for matching songs
                  Flexible(
                    child: _buildSongList(searchedSongs),
                  ),
                ],
              );
            } else {
              // Display normal folder list when not searching
              return _buildFolderList(_folders);
            }
          },
        ),
      ),
    );
  }

  /// Builds a ListTile widget representing a folder item.
  ///
  /// This function constructs a ListTile widget to display information about a folder,
  /// including its icon, name, number of songs, and a more options button.
  ///
  /// [folder]: The FolderEntity containing information about the folder.
  ///
  /// Returns a ListTile widget for the folder item.
  Widget _buildFolderItem(FolderEntity folder) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongsListPage(
              songs: folder.songs ?? [],
            ),
          ),
        );
      },
      child: ListTile(
        minLeadingWidth: 0,
        leading: SvgPicture.asset(
          'assets/iconography/music-folder-filled.svg',
          height: 32.h,
          width: 32.w,
          color: AppColors().onSurfaceVariant,
        ),
        title: Text(
          folder.folderName,
          style: Theme.of(context).textTheme.mBM.copyWith(
                color: AppColors().onSurface,
              ),
        ),
        subtitle: Text(
          '${folder.songs?.length} songs',
          style: Theme.of(context).textTheme.lBM.copyWith(
                color: AppColors().onSurfaceVariant,
              ),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_vert_rounded,
            color: AppColors().onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  // Builds a list of folder items.
  ///
  /// This function creates a ListView.builder to display a list of folder items.
  /// If the [folders] list is empty, it shows a "No Folders Found" message.
  ///
  /// [folders]: A list of FolderEntity objects representing folders.
  ///
  /// Returns a ListView.builder containing folder items or a "No Folders Found" message.
  Widget _buildFolderList(List<FolderEntity> folders) {
    if (folders.isEmpty) {
      return Center(
        child: Text(
          'No Folders Found',
          style: Theme.of(context).textTheme.mBM.copyWith(
                color: AppColors().onSurface,
              ),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final folder = folders[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SongsListPage(
                  songs: folder.songs ?? [],
                ),
              ),
            );
          },
          child: ListTile(
            minLeadingWidth: 0,
            leading: SvgPicture.asset(
              'assets/iconography/music-folder-filled.svg',
              height: 32.h,
              width: 32.w,
              color: AppColors().onSurfaceVariant,
            ),
            title: Text(
              folder.folderName,
              style: Theme.of(context).textTheme.mBM.copyWith(
                    color: AppColors().onSurface,
                  ),
            ),
            subtitle: Text(
              '${folder.songs?.length} songs',
              style: Theme.of(context).textTheme.lBM.copyWith(
                    color: AppColors().onSurfaceVariant,
                  ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert_rounded,
                color: AppColors().onSurfaceVariant,
              ),
            ),
          ),
        );
      },
      itemCount: folders.length,
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
        );
      },
      itemCount: songs.length,
    );
  }
}
