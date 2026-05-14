import 'package:todolistfirebase/src/features/auth/data/data/auth_datasource.dart';
import 'package:todolistfirebase/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<bool> signIn(String email, String password) async {
    try {
      final user = await _authDataSource.login(email, password);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _authDataSource.logout();
      return true;
    } catch (e) {
      return false;
    }
  }
  
  @override
  Future<void> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}