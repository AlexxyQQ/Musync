import 'core/common/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Paint.enableDithering = true; // Enable dithering for better quality
  // Bloc.observer = MusyncBlocObserver();
  await HiveService().init();
  setupDependencyInjection();
  runApp(
    const App(),
  );
}
