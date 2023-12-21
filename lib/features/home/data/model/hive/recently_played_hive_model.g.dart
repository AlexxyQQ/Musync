// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recently_played_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentlyPlayedHiveModelAdapter
    extends TypeAdapter<RecentlyPlayedHiveModel> {
  @override
  final int typeId = 5;

  @override
  RecentlyPlayedHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentlyPlayedHiveModel(
      date: fields[0] as String,
      expiringDate: fields[1] as String,
      songs: (fields[2] as List).cast<SongHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecentlyPlayedHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.expiringDate)
      ..writeByte(2)
      ..write(obj.songs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentlyPlayedHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
