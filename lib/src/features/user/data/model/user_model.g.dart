// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<_$UserModelImpl> {
  @override
  final int typeId = 1;

  @override
  _$UserModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$UserModelImpl(
      name: fields[0] as String,
      username: fields[1] as String,
      notificationsEnabled: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, _$UserModelImpl obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.notificationsEnabled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      name: json['name'] as String,
      username: json['username'] as String,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'notificationsEnabled': instance.notificationsEnabled,
    };
