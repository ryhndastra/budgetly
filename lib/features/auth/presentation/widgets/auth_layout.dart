import 'package:flutter/material.dart';

import '../../../../core/widgets/app_logo.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppLogo(size: 120),

                const SizedBox(height: 32),

                Text(title, style: Theme.of(context).textTheme.headlineMedium),

                const SizedBox(height: 8),

                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),

                const SizedBox(height: 32),

                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
