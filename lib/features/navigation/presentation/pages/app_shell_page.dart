import 'package:flutter/material.dart';

import '../../../../core/widgets/app_bottom_navbar.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../transaction/presentation/pages/transaction_page.dart';

class AppShellPage extends StatefulWidget {
  const AppShellPage({super.key});

  @override
  State<AppShellPage> createState() => _AppShellPageState();
}

class _AppShellPageState extends State<AppShellPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (_currentIndex) {
        0 => const HomePage(),
        1 => const TransactionPage(),
        2 => const Center(child: Text('Anggaran')),
        3 => const Center(child: Text('Target')),
        _ => const Center(child: Text('Profil')),
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
