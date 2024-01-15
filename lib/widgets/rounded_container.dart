import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final bool isTop;
  final Widget child;

  const RoundedContainer(this.isTop, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
          borderRadius: isTop
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                )
              : BorderRadius.circular(16),
          color: Colors.white),
      child: child,
    );
  }
}
