import 'dart:developer';

import 'package:musync/core/common/exports.dart';
import 'package:musync/features/library/presentation/cubit/library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit() : super(LibraryState.initial());

  void selectCategory(String category) {
    emit(state.copyWith(category: category));
    log('Selected category: $category');
  }
}
