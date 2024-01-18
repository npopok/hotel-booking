import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EmailTextField extends StatelessWidget {
  final void Function(String?)? onSaved;

  const EmailTextField({required this.onSaved, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFF14142B),
      ),
      decoration: InputDecoration(labelText: 'EmailTextField.Label'.tr()),
      inputFormatters: [
        MaskTextInputFormatter(
          filter: {"*": RegExp(r'[0-9][a-z][A-Z]')},
          type: MaskAutoCompletionType.lazy,
        )
      ],
      onSaved: onSaved,
    );
  }
}
