import 'package:go_router/go_router.dart';
import 'package:todolistfirebase/src/features/auth/presentation/screen/register_screen.dart';
import 'package:todolistfirebase/src/features/auth/presentation/screen/startpage_screen.dart';

final approuter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const StartPageScreen(),),
    //GoRoute(path: '/login', builder: (context, state) => const LoginPageScreen(),),
    GoRoute(path: '/register', builder: (context, state) => const RegisterScreen(),),
    //GoRoute(path: '/dashboard', builder: (context, state) => const DashboardPage(),),
  ],
);