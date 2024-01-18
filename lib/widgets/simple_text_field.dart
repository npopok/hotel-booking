import 'package:flutter/material.dart';
import "package:flutter/services.dart";

class SimpleTextField extends StatelessWidget {
  final String label;
  final int maxLength;
  final TextInputType keyboardType;
  final void Function(String?)? onSaved;

  const SimpleTextField({
    required this.label,
    this.maxLength = 50,
    this.keyboardType = TextInputType.text,
    this.onSaved,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFF14142B),
      ),
      decoration: InputDecoration(labelText: label),
      onSaved: onSaved,
    );
  }
}
