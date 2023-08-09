import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/features/home/presentation/viewmodel/music_query_view_model.dart';

class MusicNotFound extends StatelessWidget {
  const MusicNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('No music found'),
          ),
          const SizedBox(
            height: 20,
          ),
          // Button to refresh
          ElevatedButton(
            onPressed: () async {
              var musicQueryCubit =
                  BlocProvider.of<MusicQueryViewModel>(context);
              musicQueryCubit.getAllSongs();
              musicQueryCubit.getEverything();
            },
            child: const Text("Refresh"),
          ),
        ],
      ),
    );
  }
}
