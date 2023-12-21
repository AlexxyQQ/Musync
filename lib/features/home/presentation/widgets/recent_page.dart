import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/common/custom_widgets/custom_form_filed.dart';
import 'package:musync/core/utils/app_text_theme_extension.dart';
import 'package:musync/features/home/presentation/cubit/home_state.dart';
import 'package:musync/features/home/presentation/cubit/query_cubit.dart';

class RecentPage extends StatelessWidget {
  RecentPage({super.key});

  final TextEditingController _searchController = TextEditingController();

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
        padding: EdgeInsets.symmetric(
          horizontal: 12.h,
        ),
        child: BlocBuilder<QueryCubit, HomeState>(
          builder: (context, state) {
            if (state.recentlyPlayed == null ||
                state.recentlyPlayed?.songs == null ||
                state.recentlyPlayed!.songs.isEmpty) {
              return Center(
                child: Text(
                  'No Recently Played Songs',
                  style: Theme.of(context).textTheme.mBM.copyWith(
                        color: AppColors().onSurface,
                      ),
                ),
              );
            }

            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    height: 50.h,
                    width: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      image: DecorationImage(
                        image: Image.file(
                          File(
                            state.recentlyPlayed?.songs[index].albumArt ?? '',
                          ),
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/splash_screen/icon.png',
                              fit: BoxFit.cover,
                            );
                          },
                        ).image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    state.recentlyPlayed?.songs[index].title ?? '',
                    style: Theme.of(context).textTheme.mBM.copyWith(
                          color: AppColors().onSurface,
                        ),
                  ),
                  subtitle: Text(
                    state.recentlyPlayed?.songs[index].artist ?? '',
                    style: Theme.of(context).textTheme.mC.copyWith(
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
                );
              },
              itemCount: state.recentlyPlayed?.songs.length ?? 0,
            );
          },
        ),
      ),
    );
  }
}
