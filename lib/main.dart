import 'package:flutter/material.dart';

import 'presentation/hotel_screen.dart';
import 'presentation/payment_screen.dart';
import 'presentation/room_screen.dart';
import 'presentation/success_screen.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HotelSceeen.routeName,
      routes: {
        HotelSceeen.routeName: (_) => const HotelSceeen(),
        RoomScreen.routeName: (_) => const RoomScreen(),
        PaymentScreen.routeName: (_) => const PaymentScreen(),
        SuccessScreen.routeName: (_) => const SuccessScreen(),
      },
    );
  }
}
