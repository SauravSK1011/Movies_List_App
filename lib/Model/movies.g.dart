// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class moviesAdapter extends TypeAdapter<movies> {
  @override
  final int typeId = 0;

  @override
  movies read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return movies()
      ..moviename = fields[0] as String
      ..director = fields[1] as String
      ..image = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, movies obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.moviename)
      ..writeByte(1)
      ..write(obj.director)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is moviesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
