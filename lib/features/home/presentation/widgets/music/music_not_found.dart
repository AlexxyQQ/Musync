import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
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
              var token = await GetIt.instance.get<HiveQueries>().getValue(
                    boxName: 'users',
                    key: 'token',
                    defaultValue: '',
                  );
              musicQueryCubit.getAllSongs(token: token);
              musicQueryCubit.getEverything();
            },
            child: const Text("Refresh"),
          ),
        ],
      ),
    );
  }
}
