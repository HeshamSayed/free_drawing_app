// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unlocked_content.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UnlockedContentAdapter extends TypeAdapter<UnlockedContent> {
  @override
  final int typeId = 4;

  @override
  UnlockedContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UnlockedContent(
      unlockedBrushes: (fields[0] as List?)?.cast<BrushType>(),
      unlockedColoringPages: (fields[1] as List?)?.cast<String>(),
      achievements: (fields[2] as Map?)?.cast<String, bool>(),
      totalDrawings: fields[3] == null ? 0 : fields[3] as int,
      totalColors: fields[4] == null ? 0 : fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UnlockedContent obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.unlockedBrushes)
      ..writeByte(1)
      ..write(obj.unlockedColoringPages)
      ..writeByte(2)
      ..write(obj.achievements)
      ..writeByte(3)
      ..write(obj.totalDrawings)
      ..writeByte(4)
      ..write(obj.totalColors);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnlockedContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
