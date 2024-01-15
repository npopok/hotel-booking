import 'package:flutter/material.dart';

class PriceInfo extends StatelessWidget {
  final String price;
  final String priceInfo;

  const PriceInfo(this.price, this.priceInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: price,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.black),
          children: [
            TextSpan(
              text: priceInfo,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF828796)),
            ),
          ]),
    );
  }
}
