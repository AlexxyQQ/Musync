import 'package:flutter/material.dart';

void kShowSnackBar(String message, GlobalKey<ScaffoldState> scaffoldKey) {
  ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
