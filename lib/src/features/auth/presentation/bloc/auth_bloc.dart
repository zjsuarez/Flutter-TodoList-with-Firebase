import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:todolistfirebase/src/features/auth/domain/usecases/register_usecase.dart';
import 'package:todolistfirebase/src/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:todolistfirebase/src/features/auth/domain/usecases/sign_out_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signIn;
  final RegisterUseCase _register;
  final SignOutUseCase _signOut;

  AuthBloc(this._signIn, this._register, this._signOut)
      : super(const AuthState.initial()) {
    on<_Login>(_onLogin);
    on<_Register>(_onRegister);
    on<_Logout>(_onLogout);
  }

  Future<void> _onLogin(_Login event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      await _signIn(event.email, event.password);
      emit(const AuthState.authenticated());
    } on FirebaseAuthException catch (e) {
      emit(AuthState.error(_mapFirebaseError(e)));
    } catch (_) {
      emit(const AuthState.error('An unexpected error occurred.'));
    }
  }

  Future<void> _onRegister(_Register event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      await _register(event.email, event.password);
      emit(const AuthState.authenticated());
    } on FirebaseAuthException catch (e) {
      emit(AuthState.error(_mapFirebaseError(e)));
    } catch (_) {
      emit(const AuthState.error('An unexpected error occurred.'));
    }
  }

  Future<void> _onLogout(_Logout event, Emitter<AuthState> emit) async {
    await _signOut();
    emit(const AuthState.unauthenticated());
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
      case 'invalid-login-credentials':
        return 'Invalid email or password.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'weak-password':
        return 'Password is too weak.';
      default:
        return e.message ?? 'Authentication failed. Please try again.';
    }
  }
}
