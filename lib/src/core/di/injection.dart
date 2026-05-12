import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import 'package:todolistfirebase/src/features/dashboard/domain/entities/task.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureInjection() => getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  Box<Task> get taskBox => Hive.box<Task>('tasksBox');
}