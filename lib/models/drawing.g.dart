// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawing.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BrushTypeAdapter extends TypeAdapter<BrushType> {
  @override
  final int typeId = 0;

  @override
  BrushType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BrushType.pen;
      case 1:
        return BrushType.marker;
      case 2:
        return BrushType.pencil;
      case 3:
        return BrushType.neon;
      case 4:
        return BrushType.watercolor;
      case 5:
        return BrushType.eraser;
      default:
        return BrushType.pen;
    }
  }

  @override
  void write(BinaryWriter writer, BrushType obj) {
    switch (obj) {
      case BrushType.pen:
        writer.writeByte(0);
        break;
      case BrushType.marker:
        writer.writeByte(1);
        break;
      case BrushType.pencil:
        writer.writeByte(2);
        break;
      case BrushType.neon:
        writer.writeByte(3);
        break;
      case BrushType.watercolor:
        writer.writeByte(4);
        break;
      case BrushType.eraser:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrushTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DrawingPointAdapter extends TypeAdapter<DrawingPoint> {
  @override
  final int typeId = 1;

  @override
  DrawingPoint read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DrawingPoint(
      x: fields[0] as double,
      y: fields[1] as double,
      color: fields[2] as int,
      strokeWidth: fields[3] as double,
      brushType: fields[4] as BrushType,
      opacity: fields[5] == null ? 1.0 : fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, DrawingPoint obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.x)
      ..writeByte(1)
      ..write(obj.y)
      ..writeByte(2)
      ..write(obj.color)
      ..writeByte(3)
      ..write(obj.strokeWidth)
      ..writeByte(4)
      ..write(obj.brushType)
      ..writeByte(5)
      ..write(obj.opacity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrawingPointAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DrawingAdapter extends TypeAdapter<Drawing> {
  @override
  final int typeId = 2;

  @override
  Drawing read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Drawing(
      id: fields[0] as String,
      name: fields[1] as String,
      createdAt: fields[2] as DateTime,
      modifiedAt: fields[3] as DateTime,
      strokes: (fields[4] as List).map((dynamic e) => (e as List).cast<DrawingPoint>()).toList(),
      thumbnailPath: fields[5] as String?,
      isColoringPage: fields[6] == null ? false : fields[6] as bool,
      coloringPageId: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Drawing obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.modifiedAt)
      ..writeByte(4)
      ..write(obj.strokes)
      ..writeByte(5)
      ..write(obj.thumbnailPath)
      ..writeByte(6)
      ..write(obj.isColoringPage)
      ..writeByte(7)
      ..write(obj.coloringPageId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrawingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
