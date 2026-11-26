import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final String hintText;
  final IconData? suffix;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomForm({
    super.key,
    required this.hintText,
    this.suffix,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 5),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Color(0xff9E9E9E),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: Icon(suffix),
          ),
        ),
      ),
    );
  }
}
