// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppSettingsAdapter extends TypeAdapter<AppSettings> {
  @override
  final int typeId = 3;

  @override
  AppSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppSettings(
      isDarkMode: fields[0] == null ? false : fields[0] as bool,
      soundEnabled: fields[1] == null ? true : fields[1] as bool,
      defaultBrushSize: fields[2] == null ? 5.0 : fields[2] as double,
      defaultColor: fields[3] == null ? 0xFF000000 : fields[3] as int,
      sessionCount: fields[4] == null ? 0 : fields[4] as int,
      lastInterstitialAdTime: fields[5] as DateTime?,
      drawingsCompleted: fields[6] == null ? 0 : fields[6] as int,
      isPremium: fields[7] == null ? false : fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.isDarkMode)
      ..writeByte(1)
      ..write(obj.soundEnabled)
      ..writeByte(2)
      ..write(obj.defaultBrushSize)
      ..writeByte(3)
      ..write(obj.defaultColor)
      ..writeByte(4)
      ..write(obj.sessionCount)
      ..writeByte(5)
      ..write(obj.lastInterstitialAdTime)
      ..writeByte(6)
      ..write(obj.drawingsCompleted)
      ..writeByte(7)
      ..write(obj.isPremium);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
