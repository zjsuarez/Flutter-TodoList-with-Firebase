import 'package:injectable/injectable.dart';
import 'package:todolistfirebase/src/features/user/domain/entities/user.dart';
import 'package:todolistfirebase/src/features/user/domain/repositories/user_repository.dart';

@injectable
class SaveUserUseCase {
  final UserRepository _repository;

  SaveUserUseCase(this._repository);

  Future<void> call(User user, {String? pickedImagePath}) =>
      _repository.saveUser(user, pickedImagePath: pickedImagePath);
}
