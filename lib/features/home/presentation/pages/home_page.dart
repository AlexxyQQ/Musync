import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/features/home/presentation/cubit/home_state.dart';
import 'package:musync/features/home/presentation/cubit/query_cubit.dart';
import 'package:musync/features/home/presentation/widgets/home_artist_component.dart';
import 'package:musync/features/home/presentation/widgets/home_album_component.dart';
import 'package:musync/features/home/presentation/widgets/home_recently_played_component.dart';
import 'package:musync/features/home/presentation/widgets/home_todays_mix_component.dart';
import 'package:musync/features/home/presentation/widgets/home_top_buttons-component.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueryCubit, HomeState>(
      builder: (context, state) {
        final bool noAnyData = state.albums.isEmpty &&
            state.artists.isEmpty &&
            state.folders.isEmpty &&
            state.songs.isEmpty &&
            !state.isLoading;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TopButtons(),
                SizedBox(height: 8.h),
                const HomeRecentlyPayedComponent(),
                SizedBox(height: 8.h),
                const HomeTodaysMixComponent(),
                SizedBox(height: 8.h),
                const HomeAlbumComponent(),
                SizedBox(height: 8.h),
                const HomeArtistComponent(),
                noAnyData
                    ? const Center(
                        child: Text("No Data Found"),
                      )
                    : SizedBox(height: 8.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
