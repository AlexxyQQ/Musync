// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistHiveModelAdapter extends TypeAdapter<PlaylistHiveModel> {
  @override
  final int typeId = 2;

  @override
  PlaylistHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaylistHiveModel(
      id: fields[0] as String,
      playlist: fields[1] as String,
      dateModified: fields[5] as int?,
      dateAdded: fields[3] as int?,
      data: fields[2] as String?,
      numOfSongs: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PlaylistHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.playlist)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.dateAdded)
      ..writeByte(4)
      ..write(obj.numOfSongs)
      ..writeByte(5)
      ..write(obj.dateModified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
