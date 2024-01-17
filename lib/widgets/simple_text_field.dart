import 'package:flutter/material.dart';
import "package:flutter/services.dart";

class SimpleTextField extends StatelessWidget {
  final String label;
  final int maxLength;
  final void Function()? onTap;

  const SimpleTextField({
    required this.label,
    this.maxLength = 50,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFF14142B),
      ),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF6F6F9),
        border: InputBorder.none,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFFA9ABB7),
        ),
      ),
      onTap: () => onTap,
    );
  }
}
