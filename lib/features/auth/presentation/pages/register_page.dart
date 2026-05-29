import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_password_field.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../widgets/auth_layout.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Create Account',
      subtitle: 'Start taking control of your finances today.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppTextField(
            hintText: 'Full Name',
            prefixIcon: Icons.person_outline_rounded,
          ),

          const SizedBox(height: 16),

          const AppTextField(
            hintText: 'Email Address',
            prefixIcon: Icons.email_outlined,
          ),

          const SizedBox(height: 16),

          const AppPasswordField(),

          const SizedBox(height: 16),

          const AppPasswordField(hintText: 'Confirm Password'),

          const SizedBox(height: 24),

          AppButton(
            label: 'Create Account',
            onPressed: () {
              context.go('/dashboard');
            },
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already have an account?'),
              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text('Sign In'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
