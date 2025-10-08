import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText,
    this.validator,
    this.onTap,
    this.readOnly,
  });

  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      validator: validator,
      onTap: onTap,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
