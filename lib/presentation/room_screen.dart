import 'package:flutter/material.dart';

import "../presentation/payment_screen.dart";

class RoomScreen extends StatelessWidget {
  static const routeName = '/room';

  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ХХХХ комната")
      ),
      body: Column(
        children: [
          const Text("Room details go here..."),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const PaymentScreen())
            ),
            child: const Text("Выбрать номер"),
           )
        ]
      ),
    );
  }
}