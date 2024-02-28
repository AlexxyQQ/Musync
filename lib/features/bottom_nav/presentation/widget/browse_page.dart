import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/presentation/widgets/song_list_page.dart';
import 'package:musync/features/library/presentation/cubit/library_state.dart';
import 'package:musync/features/library/presentation/cubit/libray_cubit.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
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
                Text(
                  "Todays Mix",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // List of songs
                _songs(state),
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
          BlocProvider.of<QueryCubit>(context).state.todaysMix ?? [];

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
}
