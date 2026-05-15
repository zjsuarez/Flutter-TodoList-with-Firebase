import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:todolistfirebase/src/features/user/domain/entities/user.dart';
import 'package:todolistfirebase/src/features/user/domain/usecases/get_user_usecase.dart';
import 'package:todolistfirebase/src/features/user/domain/usecases/save_user_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final SaveUserUseCase _saveUser;
  final GetUserUseCase _getUser;

  UserBloc(this._saveUser, this._getUser) : super(const UserState.initial()) {
    on<_SaveUser>(_onSaveUser);
    on<_GetUser>(_onGetUser);
  }

  Future<void> _onSaveUser(_SaveUser event, Emitter<UserState> emit) async {
    emit(const UserState.loading());
    try {
      await _saveUser(event.user, pickedImagePath: event.pickedImagePath);
      emit(const UserState.saved());
    } catch (e) {
      emit(UserState.error(e.toString()));
    }
  }

  Future<void> _onGetUser(_GetUser event, Emitter<UserState> emit) async {
    emit(const UserState.loading());
    try {
      final user = await _getUser();
      if (user != null) {
        emit(UserState.loaded(user));
      } else {
        emit(const UserState.error('User not found'));
      }
    } catch (e) {
      emit(UserState.error(e.toString()));
    }
  }
}
