// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FolderHiveModelAdapter extends TypeAdapter<FolderHiveModel> {
  @override
  final int typeId = 4;

  @override
  FolderHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FolderHiveModel(
      path: fields[0] as String,
      folderName: fields[1] as String,
      numberOfSongs: fields[2] as String?,
      songs: (fields[3] as List?)?.cast<AppSongModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, FolderHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(1)
      ..write(obj.folderName)
      ..writeByte(2)
      ..write(obj.numberOfSongs)
      ..writeByte(3)
      ..write(obj.songs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FolderHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
