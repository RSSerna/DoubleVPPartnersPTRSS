import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? icon;
  final String? Function(String?) validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Function(String)? onFieldSubmitted;

  const CustomFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
    this.hint,
    this.icon,
    this.textInputAction,
    this.keyboardType,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor:
            Theme.of(context).inputDecorationTheme.fillColor ?? Colors.white,
      ),
      validator: validator,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
