import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import 'package:todolistfirebase/src/features/dashboard/data/model/task_model.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureInjection() => getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  Box<TaskModel> get taskBox => Hive.box<TaskModel>('tasksBox');

  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
}