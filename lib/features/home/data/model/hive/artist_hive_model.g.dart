// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArtistHiveModelAdapter extends TypeAdapter<ArtistHiveModel> {
  @override
  final int typeId = 3;

  @override
  ArtistHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArtistHiveModel(
      id: fields[0] as String,
      artist: fields[1] as String,
      numberOfAlbums: fields[2] as int?,
      numberOfTracks: fields[3] as int?,
      songs: (fields[4] as List?)?.cast<AppSongModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ArtistHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.numberOfAlbums)
      ..writeByte(3)
      ..write(obj.numberOfTracks)
      ..writeByte(4)
      ..write(obj.songs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtistHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
