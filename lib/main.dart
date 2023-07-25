import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/core/app.dart';
import 'package:musync/core/network/hive/hive_service.dart';
import 'package:musync/injection/app_injection_container.dart';
import 'package:musync/core/bloc/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Setup Dependency Injection
  setupDependencyInjection();
  await HiveService().init();

  Bloc.observer = MusyncBlocObserver();

  runApp(
    const App(),
  );
}