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

  final _pages = const [
    HomePage(),
    TransactionPage(),
    Center(child: Text('Anggaran')),
    Center(child: Text('Target')),
    Center(child: Text('Profil')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

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
