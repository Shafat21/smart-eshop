// lib/widgets/glassy_text_field.dart
import 'dart:ui';
import 'package:flutter/material.dart';

class GlassyTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscure;

  const GlassyTextField({
    Key? key,
    required this.hint,
    required this.controller,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // More opaque on light, subtler on dark
    final bgColor = isDark 
      ? Colors.white.withOpacity(0.15) 
      : Colors.white.withOpacity(0.8);
    final borderColor = isDark 
      ? Colors.white.withOpacity(0.2) 
      : Colors.black26;
    final textColor = isDark 
      ? Colors.white 
      : Colors.black87;
    final hintColor = isDark 
      ? Colors.white70 
      : Colors.black45;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor),
            ),
            child: TextFormField(
              controller: controller,
              obscureText: obscure,
              cursorColor: textColor,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: hintColor),
                border: InputBorder.none,
              ),
              validator: (val) =>
                  val == null || val.isEmpty ? 'Required' : null,
            ),
          ),
        ),
      ),
    );
  }
}
