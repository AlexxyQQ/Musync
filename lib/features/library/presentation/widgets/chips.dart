
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/core/utils/extensions/app_text_theme_extension.dart';
import 'package:musync/features/library/presentation/cubit/library_state.dart';
import 'package:musync/features/library/presentation/cubit/libray_cubit.dart';

class LibraryChips extends StatelessWidget {
  const LibraryChips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryCubit, LibraryState>(
      builder: (context, state) {
        return SizedBox(
          height: 40.h,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final String category = state.categories[index];

              return Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: SizedBox(
                  height: 40.h,
                  child: ChoiceChip(
                    label: Text(
                      category,
                      style: Theme.of(context).textTheme.mBS.copyWith(
                            color: AppLightColor.onBackground,
                          ),
                    ),
                    selected: state.category == category && category != 'All',
                    selectedColor: AppLightColor.primary,
                    disabledColor: AppColors().background,
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: state.category == category
                            ? Colors.transparent
                            : AppColors(inverseDarkMode: true).background,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    onSelected: (selected) {
                      context
                          .read<LibraryCubit>()
                          .selectCategory(selected ? category : 'Songs');
                    },
                  ),
                ),
              );
            },
            itemCount: state.categories.length,
          ),
        );
      },
    );
  }
}
