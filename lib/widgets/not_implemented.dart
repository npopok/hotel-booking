import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class NotImplemented {
  static showMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('NotImplemented'.tr()),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
