import 'package:flutter/material.dart';
import 'package:musync/src/utils/colors.dart';
import 'package:musync/src/utils/text_style.dart';
import 'package:shimmer/shimmer.dart';

class HomeFoldersShimmerEffect extends StatelessWidget {
  const HomeFoldersShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 2.6,
      children: List.generate(
        6,
        (index) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeAlbumsShimmerEffect extends StatelessWidget {
  const HomeAlbumsShimmerEffect({
    Key? key,
    required this.isDark,
    required this.cardRoundness,
    required this.mqSize,
    this.cardHeight = 240,
    this.cardWidth = 200,
    required this.isCircular,
  }) : super(key: key);
  final bool isDark;
  final bool isCircular;
  final double cardRoundness;
  final double cardHeight;
  final double cardWidth;
  final Size mqSize;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: CircleAvatar(
                          radius: cardWidth / 2,
                          backgroundColor: todoColor,
                        )),
                  )
                : Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: todoColor,
                        borderRadius: BorderRadius.circular(cardRoundness),
                      ),
                      width: cardWidth,
                      height: cardHeight - 50,
                    ),
                  ),

          ],
        );
      },
    );
  }
}
