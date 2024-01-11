import 'core/common/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = MusyncBlocObserver();
  await HiveService().init();
  setupDependencyInjection();
  runApp(
    const App(),
  );
}
