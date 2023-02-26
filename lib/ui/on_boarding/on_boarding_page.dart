import 'package:flutter/material.dart';
import 'package:musync/widgets/custom_page_indicator.dart';
import 'package:musync/ui/on_boarding/page_builder.dart';
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
          padding: const EdgeInsets.only(top: 20),
          child: Center(
            child: CustomPageIndicator(
              controller: controller,
              itemCount: 3,
              dotWidth: 80,
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
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              if (index == 0) {
                bgcol = const Color(0xffceeaca);
              } else if (index == 1) {
                bgcol = const Color(0xffd6c4ee);
              } else {
                bgcol = const Color(0xffdaccc5);
              }
              isLastPage = index == 2;
            });
          },
          scrollDirection: Axis.horizontal,
          reverse: false,
          physics: const BouncingScrollPhysics(),
          children: const [
            OnBoardPageBuilder(
              color: Color(0xffceeaca),
              imgUrl: 'assets/images/undraw_music.svg',
              title: 'Listen to your favorite music',
              subtitle: 'Listen to your favorite music',
            ),
            OnBoardPageBuilder(
              color: Color(0xffd6c4ee),
              imgUrl: 'assets/images/undraw_music.svg',
              title: 'Listen to your favorite music2',
              subtitle: 'Listen to your favorite music',
            ),
            OnBoardPageBuilder(
              color: Color(0xffdaccc5),
              imgUrl: 'assets/images/undraw_music.svg',
              title: 'Listen to your favorite music3',
              subtitle: 'Listen to your favorite music',
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
              color: bgcol,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF000000),
                    minimumSize: const Size.fromHeight(85),
                  ),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('isFirstTime', false);
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
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
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
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
                        controller.animateToPage(2,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
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
