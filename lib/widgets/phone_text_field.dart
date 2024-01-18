import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneTextField extends StatelessWidget {
  final void Function(String?)? onSaved;

  const PhoneTextField({required this.onSaved, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFF14142B),
      ),
      decoration: InputDecoration(
        labelText: 'PhoneTextField.Label'.tr(),
        hintText: 'PhoneTextField.Hint'.tr(),
      ),
      inputFormatters: [
        MaskTextInputFormatter(
          mask: 'PhoneTextField.Mask'.tr(),
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.lazy,
        )
      ],
      onSaved: onSaved,
    );
  }
}
