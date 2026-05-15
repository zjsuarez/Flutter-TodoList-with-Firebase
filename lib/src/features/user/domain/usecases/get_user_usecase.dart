import 'package:injectable/injectable.dart';
import 'package:todolistfirebase/src/features/user/domain/entities/user.dart';
import 'package:todolistfirebase/src/features/user/domain/repositories/user_repository.dart';

@injectable
class GetUserUseCase {
  final UserRepository _repository;

  GetUserUseCase(this._repository);

  Future<User?> call() => _repository.getUser();
}
