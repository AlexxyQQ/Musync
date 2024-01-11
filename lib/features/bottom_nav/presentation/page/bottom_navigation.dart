
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/core/common/custom_widgets/custom_form_filed.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:musync/features/auth/presentation/cubit/authentication_state.dart';
import 'package:musync/features/bottom_nav/presentation/widget/mini_player.dart';
import 'package:musync/features/home/presentation/cubit/home_state.dart';
import 'package:musync/features/home/presentation/pages/home_page.dart';
import 'package:musync/features/library/presentation/pages/library_page.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  bool isFirstTime = false;
  final TextEditingController _controller = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _widgetOptions = [
    const HomePage(),
    const Placeholder(),
    const LibraryPage(),
  ];

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    await get<SettingsHiveService>()
        .getSettings()
        .then((value) => isFirstTime = value.firstTime);
    BlocProvider.of<QueryCubit>(context).init();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueryCubit, HomeState>(
      builder: (blocContext, state) {
        return Scaffold(
          key: _scaffoldKey,
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
                prefixIcon: GestureDetector(
                  onTap: () {
                    // open drawer
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: Icon(
                    Icons.menu_rounded,
                    color: AppColors().onSurface,
                  ),
                ),
                fillColor: AppColors().surfaceContainerHigh,
              ),
            ),
            leadingWidth: MediaQuery.of(context).size.width,
            toolbarHeight: 80.h,
          ),
          body: Stack(
            children: [
              PageView.builder(
                controller: state.pageController,
                itemBuilder: (context, index) =>
                    _widgetOptions.elementAt(index),
                itemCount: _widgetOptions.length,
                physics: const NeverScrollableScrollPhysics(),
              ),
              Positioned(
                bottom: 12.w,
                left: 8.w,
                right: 8.w,
                child: const MiniPlayer(),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: AppColors().surface,
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
                  activeColor: AppColors().onSurface,
                  iconSize: 18.r,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: AppColors().surfaceContainerHigh,
                  color: PrimitiveColors.grey500,
                  textStyle: Theme.of(context)
                      .textTheme
                      .bBM
                      .copyWith(color: AppColors().onSurface),
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
                  selectedIndex: state.selectedIndex,
                  onTabChange: (index) {
                    BlocProvider.of<QueryCubit>(context)
                        .updateSelectedIndex(index);
                  },
                ),
              ),
            ),
          ),
          drawer: const AppDrawer(),
        );
      },
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors().surface,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: (state.loggedUser != null &&
                              state.loggedUser?.id != null)
                          ? CachedNetworkImage(
                              imageUrl: state.loggedUser!.profilePic ?? "",)
                          : Image.asset('assets/default_profile.jpeg'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      (state.loggedUser != null && state.loggedUser?.id != null)
                          ? state.loggedUser?.username ?? "---"
                          : 'Guest',
                      style: Theme.of(context).textTheme.lBM.copyWith(
                            color: AppColors().onSurface,
                          ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.mBM.copyWith(
                        color: AppColors().onSurface,
                      ),
                ),
                onTap: () async {
                  BlocProvider.of<AuthenticationCubit>(context).logout();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.getStartedRoute,
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
