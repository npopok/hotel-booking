import 'package:flutter/material.dart';

class DateTextField extends StatelessWidget {
  final String label;
  final DateTime initialDate;
  final void Function(DateTime)? onUpdate;
  final TextEditingController controller = TextEditingController();

  DateTextField({
    required this.label,
    required this.initialDate,
    this.onUpdate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialDate.toIso8601String(),
      keyboardType: TextInputType.datetime,
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
      onTap: () async {
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 36500)),
          lastDate: DateTime.now(),
        );
        if (date != null && onUpdate != null) onUpdate!(date);
      },
    );
  }
}
