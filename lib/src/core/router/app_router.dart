import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todolistfirebase/src/core/di/injection.dart';
import 'package:todolistfirebase/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:todolistfirebase/src/features/auth/presentation/screen/onboarding/onboarding_screen.dart';
import 'package:todolistfirebase/src/features/auth/presentation/screen/register_screen.dart';
import 'package:todolistfirebase/src/features/auth/presentation/screen/login_screen.dart';
import 'package:todolistfirebase/src/features/auth/presentation/screen/startpage_screen.dart';
import 'package:todolistfirebase/src/features/dashboard/presentation/bloc/dashboard/bloc/dashboard_bloc.dart';
import 'package:todolistfirebase/src/features/dashboard/presentation/screens/dashboard_screen.dart';

final appRouter = GoRouter(
  initialLocation: getIt<AuthRepository>().isLoggedIn ? '/dashboard' : '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const StartPageScreen(),),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen(),),
    GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
    GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingScreen()),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<DashboardBloc>()..add(const DashboardEvent.getTasks()),
        child: const DashboardScreen(),
      ),
    ),
  ],
);