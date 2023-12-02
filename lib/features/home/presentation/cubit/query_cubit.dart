import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/core/common/hive_service/setting_hive_service.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/home/presentation/cubit/home_state.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/usecase/get_songs_usecase.dart';

class QueryCubit extends Cubit<HomeState> {
  final GetSongsUseCase getSongsUseCase;
  final SettingsHiveService settingsHiveService;

  QueryCubit({
    required this.getSongsUseCase,
    required this.settingsHiveService,
  }) : super(HomeState.initial()) {
    init();
  }

  void init() async {
    final settings = await settingsHiveService.getSettings();
    await fetchMusic(first: settings.firstTime);
  }

  Future<void> fetchMusic({bool? first}) async {
    emit(
      state.copyWith(
        isLoading: true,
        isSuccess: false,
        error: null,
        count: 0,
      ),
    );
    try {
      // get permission
      await Permission.storage.request();
      final data = await getSongsUseCase.call(
        GetSongsParams(
          onProgress: (count) {
            emit(
              state.copyWith(
                isLoading: true,
                isSuccess: false,
                error: null,
                count: count,
              ),
            );
          },
          first: first,
        ),
      );

      data.fold((l) => Left(l), (r) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            error: null,
            count: state.count,
            songs: r,
          ),
        ); // Pass the final list of songs
      });
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          error: AppErrorHandler(message: e.toString(), status: false),
          count: state.count,
        ),
      );
    }
  }
}
