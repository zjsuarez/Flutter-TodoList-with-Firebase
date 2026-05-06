import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolistfirebase/src/core/router/app_router.dart';

void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  
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
