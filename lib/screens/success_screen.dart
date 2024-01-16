import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Заказ оплачен")),
      body: const Column(children: [
        Text("Ваш заказ принят в работу"),
        ElevatedButton(
          onPressed: null,
          child: Text("Супер!"),
        )
      ]),
    );
  }
}
