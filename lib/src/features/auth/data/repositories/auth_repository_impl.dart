import 'package:injectable/injectable.dart';
import 'package:todolistfirebase/src/features/auth/data/datasources/auth_datasource.dart';
import 'package:todolistfirebase/src/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  bool get isLoggedIn => _authDataSource.currentUser != null;

  @override
  Future<void> signIn(String email, String password) async {
    await _authDataSource.login(email, password);
  }

  @override
  Future<void> register(String email, String password) async {
    await _authDataSource.register(email, password);
  }

  @override
  Future<void> signOut() async {
    await _authDataSource.logout();
  }
}
