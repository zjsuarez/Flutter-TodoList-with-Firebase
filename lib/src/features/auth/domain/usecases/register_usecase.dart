import 'package:injectable/injectable.dart';
import 'package:todolistfirebase/src/features/auth/domain/repositories/auth_repository.dart';

@injectable
class RegisterUseCase {
  final AuthRepository _repository;
  RegisterUseCase(this._repository);

  Future<void> call(String email, String password) =>
      _repository.register(email, password);
}
