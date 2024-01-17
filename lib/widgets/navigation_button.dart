import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const NavigationButton({
    required this.title,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            minimumSize: const Size.fromHeight(48),
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF0D72FF)),
        onPressed: onPressed,
        child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)));
  }
}
