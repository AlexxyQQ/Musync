import 'package:flutter/material.dart';
import 'package:musync/src/utils/colors.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KAppBar({
    super.key,
    required this.isDark,
    required this.mqSize,
  });

  final bool isDark;
  final Size mqSize;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: isDark ? blackColor : whiteColor,
      toolbarHeight: 70,
      elevation: 0,
      centerTitle: true,
      leadingWidth: mqSize.width,
      leading: Builder(
        builder: (BuildContext context) {
          return Center(
            child: Container(
              width: mqSize.width * 0.8,
              height: 48,
              decoration: BoxDecoration(
                color: isDark ? offBlackColor : offWhiteColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  // Drawer Button
                  IconButton(
                    icon: Icon(
                      Icons.menu_rounded,
                      color: isDark ? whiteColor : blackColor,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                  // Search Bar
                  SizedBox(
                    width: mqSize.width * 0.6,
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Music....',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
