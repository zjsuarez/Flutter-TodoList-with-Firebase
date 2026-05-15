part of 'user_bloc.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.saveUser(
    User user, {
    String? pickedImagePath,
  }) = _SaveUser;
  const factory UserEvent.getUser() = _GetUser;
}
