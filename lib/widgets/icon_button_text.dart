import 'package:flutter/material.dart';

class IconButtonsText extends StatelessWidget {
  final dynamic icon;
  final double height;
  final double width;
  final VoidCallback onPressed;
  final Color bgcolor;
  final String text;
  final Color textColor;

  const IconButtonsText({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.height = 60,
    this.width = 50,
    this.bgcolor = Colors.white,
    required this.text,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          maximumSize: const Size(500, 150),
          backgroundColor: bgcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        onPressed: onPressed,
        child: SizedBox(
          height: height,
          width: width,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon is IconData
                  ? Icon(
                      icon,
                      size: 40,
                      color: Colors.black,
                    )
                  : Image.asset(
                      'assets/icons/google.png',
                      height: 30,
                      width: 30,
                    ),
              const SizedBox(
                width: 15,
              ),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontFamily: 'Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
