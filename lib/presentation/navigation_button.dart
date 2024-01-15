import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String title;
  final Widget Function(BuildContext) navigate;

  const NavigationButton(this.title, this.navigate);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            minimumSize: const Size.fromHeight(48),
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF0D72FF)),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: navigate)),
        child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)));
  }
}
