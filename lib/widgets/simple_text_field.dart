import 'package:flutter/material.dart';
import "package:flutter/services.dart";
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:easy_localization/easy_localization.dart';

enum TextFieldType { text, number, phone, email }

class SimpleTextField extends StatefulWidget {
  final TextFieldType type;
  final String label;
  final String? hint;
  final int minLength;
  final int maxLength;

  final void Function(String?)? onSaved;

  const SimpleTextField({
    required this.type,
    required this.label,
    this.hint,
    this.minLength = 0,
    this.maxLength = 50,
    this.onSaved,
    super.key,
  });

  @override
  State<SimpleTextField> createState() => _SimpleTextFieldState();
}

class _SimpleTextFieldState extends State<SimpleTextField> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isValid = true;

  bool validateText() {
    String text = controller.text;
    switch (widget.type) {
      case TextFieldType.text:
        return isValid = (text.length >= widget.minLength && text.length <= widget.maxLength);
      case TextFieldType.number:
        return isValid = RegExp(r'[0-9]').hasMatch(text);
      case TextFieldType.phone:
        return isValid = RegExp(r'^\+7\s\(\d\d\d\)\s\d\d\d-\d\d-\d\d$').hasMatch(text);
      case TextFieldType.email:
        return isValid = RegExp(r'^[a-zA-Z0-9.a-zA-Z0-9.!#%&*+-=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+')
            .hasMatch(text);
      default:
        return false;
    }
  }

  TextInputType getKeyboardType() {
    switch (widget.type) {
      case TextFieldType.text:
        return TextInputType.text;
      case TextFieldType.number:
        return TextInputType.number;
      case TextFieldType.phone:
        return TextInputType.phone;
      case TextFieldType.email:
        return TextInputType.emailAddress;
      default:
        return TextInputType.text;
    }
  }

  TextInputFormatter getInputFormatter() {
    switch (widget.type) {
      case TextFieldType.text:
        return LengthLimitingTextInputFormatter(widget.maxLength);
      case TextFieldType.number:
        return LengthLimitingTextInputFormatter(widget.maxLength);
      case TextFieldType.phone:
        return MaskTextInputFormatter(
          mask: 'PhoneTextField.Mask'.tr(),
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.lazy,
        );
      case TextFieldType.email:
        return MaskTextInputFormatter(
          filter: {"*": RegExp(r'[0-9][a-z][A-Z]')},
          type: MaskAutoCompletionType.lazy,
        );
      default:
        return LengthLimitingTextInputFormatter(50);
    }
  }

  @override
  void initState() {
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        validateText();
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: getKeyboardType(),
      inputFormatters: [getInputFormatter()],
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFF14142B),
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        fillColor: isValid ? const Color(0xFFF6F6F9) : const Color(0xFFEB5757).withOpacity(0.15),
      ),
      validator: (value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) setState(() {});
        });
        return validateText() ? null : '';
      },
      //onChanged: (value) => (setState(() => isValid = true)),
      onSaved: widget.onSaved,
    );
  }
}
