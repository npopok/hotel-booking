import 'package:flutter/material.dart';
import 'package:hotel_booking/presentation/success_screen.dart';

class PaymentScreen extends StatelessWidget {
  static const routeName = '/payment';

  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Бронирование")
      ),
      body: Column(
        children: [
          const Text("Booking details go here..."),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const SuccessScreen())
            ),
            child: const Text("Оплатить ХХХ рублей"),
           )
        ]
      ),
    );
  }
}