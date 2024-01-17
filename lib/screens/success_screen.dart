import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../screens/hotel_screen.dart';
import '../widgets/navigation_button.dart';

class SuccessScreen extends StatelessWidget {
  final int orderId;

  const SuccessScreen(this.orderId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('SuccessScreen.Title').tr()),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 94,
                  height: 94,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF6F6F9),
                  ),
                ),
                const Text(
                  '🎉',
                  style: TextStyle(fontSize: 40),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'SuccessScreen.Confirmation'.tr(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'SuccessScreen.Text'.tr(args: [orderId.toString()]),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF828796),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Color(0xFFE8E9EC)),
            ),
            color: Colors.white),
        child: NavigationButton(
          title: 'SuccessScreen.OK'.tr(),
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const HotelSceeen(),
            ),
            (_) => false,
          ),
        ),
      ),
    );
  }
}
