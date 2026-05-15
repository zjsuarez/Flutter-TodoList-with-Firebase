import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todolistfirebase/src/features/auth/data/datasources/auth_datasource.dart';
import 'package:todolistfirebase/src/features/user/data/model/user_model.dart';

@lazySingleton
class UserDataSource {
  final FirebaseFirestore _db;
  final AuthDataSource _authDataSource;

  UserDataSource(this._db, this._authDataSource);

  String get _uid {
    final uid = _authDataSource.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');
    return uid;
  }

  Future<String> getAvatarLocalPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/avatar_$_uid.jpg';
  }

  Future<void> saveUser(UserModel user, {String? pickedImagePath}) async {
    if (pickedImagePath != null) {
      final dest = await getAvatarLocalPath();
      await File(pickedImagePath).copy(dest);
    }

    await _db.collection('users').doc(_uid).set({
      'name': user.name,
      'username': user.username,
    });
  }

  Future<UserModel?> getUser() async {
    final doc = await _db.collection('users').doc(_uid).get();
    if (!doc.exists || doc.data() == null) return null;
    return UserModel.fromJson(doc.data()!);
  }
}
