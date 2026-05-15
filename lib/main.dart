import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todolistfirebase/src/core/di/injection.dart';
import 'package:todolistfirebase/src/core/router/app_router.dart';
import 'package:todolistfirebase/src/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todolistfirebase/src/features/user/data/model/user_model.dart';
import 'firebase_options.dart';

import 'package:todolistfirebase/src/features/dashboard/data/model/task_model.dart';
import 'package:todolistfirebase/src/features/dashboard/domain/entities/task.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Hive initialization
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<TaskModel>('tasksBox');

  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<UserModel>('userBox');
  //GetIt configuration initialization
  configureInjection();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: MaterialApp.router(
        routerConfig: appRouter,
      ),
    );
  }
}
