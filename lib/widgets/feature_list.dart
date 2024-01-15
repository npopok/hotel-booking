import 'package:flutter/material.dart';

class FeatureList extends StatelessWidget {
  final List<String> features;

  const FeatureList(this.features, {super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List<Container>.generate(
        features.length,
        (index) => Container(
          padding: const EdgeInsets.all(5),
          color: const Color(0xFFFBFBFC),
          child: Text(
            features[index],
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF828796)),
          ),
        ),
      ),
    );
  }
}
