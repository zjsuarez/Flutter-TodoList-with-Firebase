import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolistfirebase/src/core/di/injection.dart';
import 'package:todolistfirebase/src/core/router/app_router.dart';
import 'package:todolistfirebase/src/features/dashboard/data/model/task_model.dart';
import 'package:todolistfirebase/src/features/dashboard/domain/entities/task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<TaskModel>('tasksBox');
  configureInjection();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: approuter,
    );
  }
}
