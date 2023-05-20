import 'package:flutter/material.dart';
import 'package:musync/src/utils/colors.dart';
import 'package:musync/src/utils/text_style.dart';

class HomeOtherSection extends StatelessWidget {
  const HomeOtherSection({
    Key? key,
    required this.isDark,
    required this.sectionTitle,
    required this.cardRoundness,
    required this.mqSize,
    this.cardHeight = 240,
    this.cardWidth = 200,
    required this.isCircular,
  }) : super(key: key);

  final bool isDark;
  final String sectionTitle;
  final bool isCircular;
  final double cardRoundness;
  final double cardHeight;
  final double cardWidth;
  final Size mqSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Albums Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                sectionTitle,
                style: textStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              // Arrow Button
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 25,
                ),
                color: isDark ? Colors.white : Colors.black,
                onPressed: () {},
              ),
            ],
          ),
        ),
        // Horizontal List View of Albums
        SizedBox(
          height: cardHeight,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Card
                  isCircular
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          child: CircleAvatar(
                            radius: cardWidth / 2,
                            backgroundColor: todoColor,
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: todoColor,
                            borderRadius: BorderRadius.circular(cardRoundness),
                          ),
                          width: cardWidth,
                          height: cardHeight - 50,
                        ),
                  // Card Subtitle
                  Text(
                    'Card Subtitle',
                    style: textStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
