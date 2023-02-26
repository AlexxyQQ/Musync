import 'package:flutter/material.dart';
import 'package:musync/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  runApp(
    MyApp(
      isFirstTime: isFirstTime,
    ),
  );
}
