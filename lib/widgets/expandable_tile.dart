import 'package:flutter/material.dart';

class ExpandableTile extends StatefulWidget {
  final String title;
  final List<Widget> children;

  const ExpandableTile({
    required this.title,
    required this.children,
    super.key,
  });

  @override
  State<ExpandableTile> createState() => _ExpandableTileState();
}

class _ExpandableTileState extends State<ExpandableTile> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: EdgeInsets.zero,
      dense: true,
      horizontalTitleGap: 0,
      minLeadingWidth: 0,
      minVerticalPadding: 0,
      child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          shape: const Border(),
          initiallyExpanded: isExpanded,
          title: Text(
            widget.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          trailing: AnimatedRotation(
            turns: isExpanded ? .5 : 0,
            duration: const Duration(milliseconds: 250),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xFF0D72FF).withOpacity(0.1),
              ),
              child: const Icon(Icons.expand_less),
            ),
          ),
          onExpansionChanged: (value) => (setState(() => isExpanded = value)),
          children: widget.children),
    );
  }
}
