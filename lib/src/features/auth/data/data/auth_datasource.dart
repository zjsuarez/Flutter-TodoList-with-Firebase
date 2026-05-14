import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';


@lazySingleton
class AuthDataSource {
final FirebaseAuth _firebaseAuth;

AuthDataSource(this._firebaseAuth);

Future<UserCredential> login(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> register(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  // Para saber si el usuario ya inició sesión al abrir la app
  User? get currentUser => _firebaseAuth.currentUser;

}