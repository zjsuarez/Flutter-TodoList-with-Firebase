import 'package:injectable/injectable.dart';
import 'package:todolistfirebase/src/features/auth/domain/repositories/auth_repository.dart';

@injectable
class SignInUseCase {
  final AuthRepository _repository;
  SignInUseCase(this._repository);

  Future<void> call(String email, String password) =>
      _repository.signIn(email, password);
}
