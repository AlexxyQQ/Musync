import 'package:flutter/material.dart';

class OnBoardPageBuilder extends StatelessWidget {
  final Color color;
  final String imgUrl;
  final String title;
  final String subtitle;

  const OnBoardPageBuilder({
    super.key,
    this.color = Colors.blue,
    this.imgUrl = '',
    this.title = '',
    this.subtitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Image.asset(
          //   imgUrl,
          //   height: 200,
          //   width: 200,
          // ),
        ],
      ),
    );
  }
}
