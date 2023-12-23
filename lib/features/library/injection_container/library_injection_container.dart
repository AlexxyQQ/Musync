import 'package:musync/features/library/presentation/cubit/libray_cubit.dart';

import '../../../injection/app_injection_container.dart';

class LibraryInjectionContainer {
  void register() {
    // Cubit
    get.registerFactory(
      () => LibraryCubit(),
    );
  }
}
