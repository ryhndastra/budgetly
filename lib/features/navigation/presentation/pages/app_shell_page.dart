import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../budget/presentation/pages/budget_page.dart';
import '../../../transaction/presentation/providers/transaction_provider.dart';
import '../../../category/presentation/providers/category_provider.dart';
import '../../../../core/widgets/app_bottom_navbar.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../transaction/presentation/pages/transaction_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../budget/presentation/providers/budget_provider.dart';

class AppShellPage extends ConsumerStatefulWidget {
  const AppShellPage({super.key});

  @override
  ConsumerState<AppShellPage> createState() => _AppShellPageState();
}

class _AppShellPageState extends ConsumerState<AppShellPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final user = ref.read(authProvider);

      if (user == null) return;

      await ref.read(transactionProvider.notifier).loadTransactions(user.id);

      await ref.read(categoryProvider.notifier).loadCategories(user.id);

      await ref.read(budgetProvider.notifier).loadBudgets(user.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (_currentIndex) {
        0 => const HomePage(),
        1 => const TransactionPage(),
        2 => const BudgetPage(),
        3 => const Center(child: Text('Target')),
        _ => const ProfilePage(),
      },

      bottomNavigationBar: AppBottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
