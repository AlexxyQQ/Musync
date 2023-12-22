import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/common/custom_widgets/custom_form_filed.dart';
import 'package:musync/core/common/hive/hive_service/setting_hive_service.dart';
import 'package:musync/core/utils/extensions/app_text_theme_extension.dart';
import 'package:musync/features/bottom_nav/presentation/widget/mini_player.dart';
import 'package:musync/features/home/presentation/cubit/home_state.dart';
import 'package:musync/features/home/presentation/cubit/query_cubit.dart';
import 'package:musync/features/home/presentation/pages/home_page.dart';
import 'package:musync/injection/app_injection_container.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;
  bool isFirstTime = false;
  final TextEditingController _controller = TextEditingController();
  late final PageController _pageController;

  final List<Widget> _widgetOptions = [
    const HomePage(),
    Placeholder(),
    Placeholder(),
  ];

  @override
  void initState() {
    super.initState();
    initial();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  void initial() async {
    await get<SettingsHiveService>()
        .getSettings()
        .then((value) => isFirstTime = value.firstTime);

    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueryCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          bottomSheet: Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: const MiniPlayer(),
          ),
          appBar: AppBar(
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
              child: KTextFormField(
                controller: _controller,
                keyboardType: TextInputType.text,
                hintText: state.isLoading && isFirstTime
                    ? "Songs Loaded: ${state.count}"
                    : 'Search...........',
                contentStyle: Theme.of(context).textTheme.mBM.copyWith(
                      color: AppColors().onSurface,
                    ),
                hintTextStyle: Theme.of(context).textTheme.lBM.copyWith(
                      color: AppColors().onSurfaceVariant,
                    ),
                errorTextStyle: Theme.of(context).textTheme.mC.copyWith(
                      color: AppColors().onErrorContainer,
                    ),
                prefixIcon: Icon(
                  Icons.menu_rounded,
                  color: AppColors().onSurfaceVariant,
                ),
                fillColor: AppColors().surfaceContainer,
              ),
            ),
            leadingWidth: MediaQuery.of(context).size.width,
            toolbarHeight: 80.h,
          ),
          body: PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) => _widgetOptions.elementAt(index),
            itemCount: _widgetOptions.length,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) => setState(() => _selectedIndex = index),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: Colors.black,
                  iconSize: 18.r,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[100]!,
                  color: Colors.black,
                  textStyle: Theme.of(context)
                      .textTheme
                      .bBM
                      .copyWith(color: AppColors().onSurfaceVariant),
                  tabs: const [
                    GButton(
                      icon: Icons.home_filled,
                      text: 'Home',
                    ),
                    GButton(
                      icon: CupertinoIcons.globe,
                      text: 'Browse',
                    ),
                    GButton(
                      icon: Icons.library_music_rounded,
                      text: 'Library',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: _onItemTapped,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
