import 'package:go_router/go_router.dart';

import '../../features/navigation/presentation/pages/app_shell_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/transaction/domain/enums/transaction_type.dart';
import '../../features/transaction/presentation/pages/add_transaction_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashPage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(path: '/app', builder: (context, state) => const AppShellPage()),
    GoRoute(
      path: '/add-transaction',
      builder: (context, state) {
        final type = state.extra as TransactionType;

        return AddTransactionPage(type: type);
      },
    ),
  ],
);
