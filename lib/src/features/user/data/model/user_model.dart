import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todolistfirebase/src/features/user/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  @HiveType(typeId: 1, adapterName: 'UserAdapter')
  const factory UserModel({
    @HiveField(0) required String name,
    @HiveField(1) required String username,
    @HiveField(2) @Default(true) bool notificationsEnabled,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  User toDomain() => User(
        name: name,
        username: username,
        notificationsEnabled: notificationsEnabled,
      );

  factory UserModel.fromDomain(User user) => UserModel(
        name: user.name,
        username: user.username,
        notificationsEnabled: user.notificationsEnabled,
      );
}
