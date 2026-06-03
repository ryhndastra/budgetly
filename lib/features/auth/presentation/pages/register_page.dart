import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_password_field.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_layout.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _fullNameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  Future<void> _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password dan konfirmasi password tidak sama'),
        ),
      );
      return;
    }

    try {
      setState(() {
        _loading = true;
      });

      await ref
          .read(authProvider.notifier)
          .register(
            fullName: _fullNameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registrasi berhasil')));

      context.go('/app');
    } catch (e) {
      if (!mounted) return;

      String message = 'Registrasi gagal';

      if (e is DioException) {
        message = e.response?.data['error'] ?? 'Registrasi gagal';
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Create Account',
      subtitle: 'Start taking control of your finances today.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: _fullNameController,
            hintText: 'Full Name',
            prefixIcon: Icons.person_outline_rounded,
          ),

          const SizedBox(height: 16),

          AppTextField(
            controller: _emailController,
            hintText: 'Email Address',
            prefixIcon: Icons.email_outlined,
          ),

          const SizedBox(height: 16),

          AppPasswordField(controller: _passwordController),

          const SizedBox(height: 16),

          AppPasswordField(
            controller: _confirmPasswordController,
            hintText: 'Confirm Password',
          ),

          const SizedBox(height: 24),

          AppButton(
            label: _loading ? 'Creating Account...' : 'Create Account',
            onPressed: _loading ? null : _register,
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
