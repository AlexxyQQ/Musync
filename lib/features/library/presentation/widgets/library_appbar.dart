import 'package:flutter/material.dart';
import 'package:musync/config/constants/constants.dart';

class LibraryAppBar extends StatefulWidget implements PreferredSizeWidget {
  const LibraryAppBar({
    super.key,
    required this.isDark,
    required this.mqSize,
    required this.changeSort,
  });

  final bool isDark;
  final Size mqSize;
  final Function changeSort;

  @override
  State<LibraryAppBar> createState() => _LibraryAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(40);
}

class _LibraryAppBarState extends State<LibraryAppBar> {
  List<String> filterButtons = [
    'All',
    'Folders',
    'Albums',
    'Artists',
    'Playlists',
  ];
  String sortBy = "All";
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 40,
      scrolledUnderElevation: 0,
      leadingWidth: widget.mqSize.width,
      leading: Row(
        children: [
          // Cross Button if filter is applied
          if (sortBy != 'All')
            IconButton(
              onPressed: () async {
                widget.changeSort('All');
                setState(() {
                  sortBy = 'All';
                });
                // ref.watch(sortSongProvider.notifier).state = 'All';
              },
              icon: const Icon(
                Icons.close_rounded,
                size: 25,
                color: KColors.accentColor,
              ),
            ),
          // Filter Buttons
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            height: 35,
            width: (sortBy != 'All')
                ? widget.mqSize.width * 0.85
                : widget.mqSize.width,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ElevatedButton(
                    onPressed: () {
                      widget.changeSort(filterButtons[index]);
                      setState(() {
                        sortBy = filterButtons[index];
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      //  if is filter button is selected then change color
                      backgroundColor: filterButtons[index] == sortBy
                          ? KColors.accentColor
                          : widget.isDark
                              ? KColors.blackColor
                              : KColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: filterButtons[index] == sortBy
                            ? BorderSide.none
                            : BorderSide(
                                color: widget.isDark
                                    ? KColors.whiteColor
                                    : KColors.blackColor,
                                width: 1,
                              ),
                      ),
                      minimumSize: const Size(60, 20),
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 10,
                        minHeight: 20,
                        maxWidth: 60,
                      ),
                      child: Text(
                        filterButtons[index],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // actions: [
      //   // Create Playlist
      //   IconButton(
      //     onPressed: () {
      //       // TODO: Create Playlist
      //     },
      //     icon: const Icon(
      //       Icons.add_rounded,
      //       size: 25,
      //       color: KColors.accentColor,
      //     ),
      //   ),
      // ],
    );
  }
}
