// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlbumHiveModelAdapter extends TypeAdapter<AlbumHiveModel> {
  @override
  final int typeId = 1;

  @override
  AlbumHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlbumHiveModel(
      id: fields[0] as String,
      album: fields[1] as String,
      artist: fields[2] as String?,
      artistId: fields[3] as String?,
      numOfSongs: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AlbumHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.album)
      ..writeByte(2)
      ..write(obj.artist)
      ..writeByte(3)
      ..write(obj.artistId)
      ..writeByte(4)
      ..write(obj.numOfSongs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
