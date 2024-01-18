import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../utils/value_formatter.dart';

class DateTextField extends StatefulWidget {
  final String label;
  final DateTime minDate;
  final DateTime maxDate;
  final void Function(DateTime)? onSaved;

  const DateTextField({
    required this.label,
    required this.minDate,
    required this.maxDate,
    this.onSaved,
    super.key,
  });

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  DateTime? value;
  final TextEditingController controller = TextEditingController();
  bool isValid = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.datetime,
      readOnly: true,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFF14142B),
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        fillColor: isValid ? const Color(0xFFF6F6F9) : const Color(0xFFEB5757).withOpacity(0.15),
      ),
      inputFormatters: [
        MaskTextInputFormatter(
          mask: '##.##.####',
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.lazy,
        )
      ],
      validator: (value) {
        isValid = controller.text.isNotEmpty;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) setState(() {});
        });
        return isValid ? null : '';
      },
      onTap: () async {
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: value,
          firstDate: widget.minDate,
          lastDate: widget.maxDate,
        );
        if (date != null) {
          value = date;
          isValid = true;
          if (widget.onSaved != null) widget.onSaved!(value!);
          setState(() => controller.text = ValueFormatter.formatDate(value!));
        }
      },
    );
  }
}
