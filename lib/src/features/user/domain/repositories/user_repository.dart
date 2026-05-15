import 'package:todolistfirebase/src/features/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<void> saveUser(User user, {String? pickedImagePath});
  Future<User?> getUser();
}
