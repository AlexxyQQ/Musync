import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/presentation/widgets/song_list_page.dart';
import 'package:musync/features/library/presentation/cubit/library_state.dart';
import 'package:musync/features/library/presentation/cubit/libray_cubit.dart';
import 'package:musync/features/library/presentation/widgets/album_list_page.dart';
import 'package:musync/features/library/presentation/widgets/artist_list_page.dart';
import 'package:musync/features/library/presentation/widgets/chips.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryCubit, LibraryState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Chips for categories
                const LibraryChips(),
                // List of songs
                _songs(state),
                // List of albums
                _albums(state),
                // List of artists
                _artists(state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _songs(LibraryState state) {
    if (state.category == 'Songs') {
      final List<SongEntity> songs =
          BlocProvider.of<QueryCubit>(context).state.songs;

      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 50.h,
        child: SongsListPage(
          appbar: false,
          borderRadius: 12.r,
          coverHeight: 50.h,
          coverWidth: 50.w,
          songs: songs,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _albums(LibraryState state) {
    if (state.category == 'Albums') {
      return const AlbumListPage();
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _artists(LibraryState state) {
    if (state.category == 'Artists') {
      return const ArtistListPage();
    } else {
      return const SizedBox.shrink();
    }
  }
}
