import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/features/home/presentation/cubit/home_state.dart';
import 'package:musync/features/home/presentation/cubit/query_cubit.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueryCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Scaffold(
              body: Center(child: Text('Songs Loaded: ${state.count}')),);
        } else if (state.isSuccess) {
          return Scaffold(
            body: ListView.builder(
              itemCount: state.songs!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.songs![index].title),
                  subtitle: Text("${state.songs?[index].artist}"),
                );
              },
            ),
          );
        } else if (state.error != null) {
          return Scaffold(
              body: Center(child: Text('Error: ${state.error!.message}')),);
        }
        return Container();
      },
    );
  }
}
