abstract class AuthRepository {
  bool get isLoggedIn;
  Future<void> signIn(String email, String password);
  Future<void> register(String email, String password);
  Future<void> signOut();
}