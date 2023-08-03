// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class SocketState {
  final UserEntity? loggedUser;
  final String model;
  final bool isLoading;
  final String? error;
  final int? index;
  final List<SongEntity> queue;

  SocketState({
    required this.loggedUser,
    required this.model,
    required this.isLoading,
    this.error,
    this.index,
    required this.queue,
  });

  factory SocketState.initial() {
    return SocketState(
      loggedUser: null,
      isLoading: false,
      model: '',
      error: null,
      index: null,
      queue: [],
    );
  }

  SocketState copyWith({
    UserEntity? loggedUser,
    String? model,
    bool? isLoading,
    String? error,
    int? index,
    List<SongEntity>? queue,
  }) {
    return SocketState(
      loggedUser: loggedUser ?? this.loggedUser,
      model: model ?? this.model,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      index: index ?? this.index,
      queue: queue ?? this.queue,
    );
  }

  @override
  String toString() {
    return 'SocketState(loggedUser: $loggedUser, model: $model, isLoading: $isLoading, error: $error, index: $index, queue: $queue)';
  }

  @override
  bool operator ==(covariant SocketState other) {
    if (identical(this, other)) return true;

    return other.loggedUser == loggedUser &&
        other.model == model &&
        other.isLoading == isLoading &&
        other.error == error &&
        other.index == index &&
        listEquals(other.queue, queue);
  }

  @override
  int get hashCode {
    return loggedUser.hashCode ^
        model.hashCode ^
        isLoading.hashCode ^
        error.hashCode ^
        index.hashCode ^
        queue.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'loggedUser': loggedUser?.toMap(),
      'model': model,
      'isLoading': isLoading,
      'error': error,
      'index': index,
      'queue': queue.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}
