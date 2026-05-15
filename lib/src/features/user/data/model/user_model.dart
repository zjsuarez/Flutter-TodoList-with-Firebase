import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todolistfirebase/src/features/user/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  @HiveType(typeId: 0, adapterName: 'UserAdapter')
  const factory UserModel({
    @HiveField(0) required String name,
    @HiveField(1) required String username,
  }) = _UserModel;
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  // ---MAPPERS---

  User toDomain() {
    return User(
      name: name,
      username: username,
    );
  }

  factory UserModel.fromDomain(User user) {
    return UserModel(
      name: user.name,
      username: user.username,
    );
  }
}