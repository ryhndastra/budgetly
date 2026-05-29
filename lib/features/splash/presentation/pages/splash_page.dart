import 'package:flutter/material.dart';

import '../../../../core/widgets/app_logo.dart';
import '../../../../app/theme/app_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppLogo(size: 140),

            const SizedBox(height: 24),

            const Text(
              'Budgetly',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 8),

            Text(
              'Plan. Track. Grow.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
