import 'package:flutter/material.dart';
import 'package:musync/ui/on_boarding/provider/google_sign_in.dart';
import 'package:musync/widgets/custom_page_indicator.dart';
import 'package:musync/ui/on_boarding/page_builder.dart';
import 'package:musync/widgets/icon_button_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStartedPage extends StatefulWidget {
  static const String routeName = '/';
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  static PageController controller = PageController();
  bool isLastPage = false;
  Color bgcol = const Color(0xffceeaca);

  List<dynamic> pages = const [
    OnBoardPageBuilder(
      color: Color(0xffceeaca),
      imgUrl: 'assets/images/undraw_music.svg',
      title: 'Welcome to Musync',
      subtitle:
          'Seamlessly switch between your computer and phone without missing a beat.',
    ),
    OnBoardPageBuilder(
      color: Color(0xffd6c4ee),
      imgUrl: 'assets/images/undraw_music.svg',
      title: 'Listen to you library offline',
      subtitle: 'Musync support playing offline media saved in you device.',
    ),
    OnBoardPageBuilder(
      color: Color(0xFF9EBB8E),
      imgUrl: 'assets/images/undraw_music.svg',
      title: 'Get started now!!',
      subtitle:
          'Login with you Google account and forget about remembering you password.',
    ),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcol,
      appBar: AppBar(
        toolbarHeight: 15,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child: CustomPageIndicator(
              controller: controller,
              itemCount: 3,
              dotWidth: 50,
              dotHeight: 5,
              trailing: true,
              activeColor: Colors.black,
              inactiveColor: const Color.fromARGB(94, 255, 255, 255),
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 100),
        child: PageView.builder(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              if (index == 0) {
                bgcol = const Color(0xffceeaca);
              } else if (index == 1) {
                bgcol = const Color(0xffd6c4ee);
              } else {
                bgcol = const Color(0xFF9EBB8E);
              }
              isLastPage = index == 2;
            });
          },
          scrollDirection: Axis.horizontal,
          reverse: false,
          physics: const BouncingScrollPhysics(),
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return pages[index];
          },
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
              height: 110,
              color: bgcol,
              child: IconButtonsText(
                text: "Get Started",
                textColor: Colors.white,
                bgcolor: Colors.black,
                width: MediaQuery.of(context).size.width * 0.85,
                height: 70,
                icon: "assets/icons/google.png",
                onPressed: () async {
                  try {
                    setState(() {});
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    await provider.googleLogin();

                    if (provider.user != null) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/auth_check', (route) => false);
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('isFirstTime', false);
                    } else {
                      // Handle the case where the user is not signed in.
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            )
          : Container(
              height: 120,
              width: double.infinity,
              color: bgcol,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color(0xFF000000),
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                      },
                      child: const Text('Next'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.transparent,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {
                        controller.animateToPage(3,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: const Text('Skip'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
