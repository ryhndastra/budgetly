import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final String? label;
  final TextEditingController? controller;
  final bool obscureText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final int maxLines;

  const AppTextField({
    super.key,
    required this.hintText,
    this.label,
    this.controller,
    this.obscureText = false,
    this.prefixIcon,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
        ],

        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          ),
        ),
      ],
    );
  }
}
