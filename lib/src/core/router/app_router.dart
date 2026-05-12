import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todolistfirebase/src/core/di/injection.dart';
import 'package:todolistfirebase/src/features/auth/presentation/screen/register_screen.dart';
import 'package:todolistfirebase/src/features/auth/presentation/screen/login_screen.dart';
import 'package:todolistfirebase/src/features/auth/presentation/screen/startpage_screen.dart';
import 'package:todolistfirebase/src/features/dashboard/presentation/bloc/dashboard/bloc/dashboard_bloc.dart';
import 'package:todolistfirebase/src/features/dashboard/presentation/screens/dashboard_screen.dart';

final approuter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const StartPageScreen(),),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen(),),
    GoRoute(path: '/register', builder: (context, state) => const RegisterScreen(),),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<DashboardBloc>()..add(const DashboardEvent.getTasks()),
        child: const DashboardScreen(),
      ),
    ),
  ],
);