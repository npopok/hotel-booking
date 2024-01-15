import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final int rating;
  final String ratingName;

  const RatingBar(this.rating, this.ratingName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFFC700).withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: Color(0xFFFFA800), size: 20),
            Text(
              '$rating $ratingName',
              style: const TextStyle(
                  color: Color(0xFFFFA800), fontSize: 16, fontWeight: FontWeight.w500),
            )
          ]),
    );
  }
}
