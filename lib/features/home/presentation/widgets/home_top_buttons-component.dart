import 'package:flutter/material.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/common/custom_widgets/custom_buttom.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        // Favorite Button
        KButton(
          onPressed: () {},
          label: 'Favorite',
          backgroundColor: AppColors().primaryContainer,
          foregroundColor: AppColors().onPrimaryContainer,
          borderRadius: 12,
          svg: 'assets/iconography/heart-outline.svg',
        ),
        // Recent Button
        KButton(
          onPressed: () {},
          label: 'Recent',
          backgroundColor: AppColors().secondaryContainer,
          foregroundColor: AppColors().onSecondaryContainer,
          borderRadius: 12,
          svg: 'assets/iconography/recent.svg',
        ),
        // Folder Button
        KButton(
          onPressed: () {},
          label: 'Folder',
          backgroundColor: AppColors().accentContainer,
          foregroundColor: AppColors().onAccentContainer,
          borderRadius: 12,
          svg: 'assets/iconography/music-folder-outline.svg',
        ),
        //  Shuffle Button
        KButton(
          onPressed: () {},
          label: 'Shuffle',
          backgroundColor: AppColors().errorContainer,
          foregroundColor: AppColors().onErrorContainer,
          borderRadius: 12,
          svg: 'assets/iconography/shuffle.svg',
        ),
      ],
    );
  }
}
