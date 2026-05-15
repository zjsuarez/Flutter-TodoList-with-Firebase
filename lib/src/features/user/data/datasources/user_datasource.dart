import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolistfirebase/src/core/di/injection.dart';
import 'package:todolistfirebase/src/features/auth/data/datasources/auth_datasource.dart';
import 'package:todolistfirebase/src/features/user/domain/entities/user.dart';

class userDataSource{
  final _db = FirebaseFirestore.instance;
  final AuthDataSource _authDataSource = getIt<AuthDataSource>();
  

  Future<void> addUser(User user) async {

    final userData = _authDataSource.currentUser;
    final String? userUid = userData?.uid;

    await _db.collection("users").doc(userUid).set(user.toMap());
  }

  Future<void> getUser(User user) async {
    await _db.collection("users").where("name", isEqualTo: user.name).where("username", isEqualTo: user.username).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
          print(doc["name"]);
      });
    });
  }





}