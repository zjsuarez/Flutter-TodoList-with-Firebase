import 'package:injectable/injectable.dart';
import 'package:todolistfirebase/src/features/user/data/datasources/user_datasource.dart';
import 'package:todolistfirebase/src/features/user/data/model/user_model.dart';
import 'package:todolistfirebase/src/features/user/domain/entities/user.dart';
import 'package:todolistfirebase/src/features/user/domain/repositories/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserDataSource _dataSource;

  UserRepositoryImpl(this._dataSource);

  @override
  Future<void> saveUser(User user, {String? pickedImagePath}) =>
      _dataSource.saveUser(UserModel.fromDomain(user),
          pickedImagePath: pickedImagePath);

  @override
  Future<User?> getUser() async {
    final model = await _dataSource.getUser();
    return model?.toDomain();
  }
}
