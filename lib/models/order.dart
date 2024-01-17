import '../models/hotel.dart';
import '../models/room.dart';
import '../models/tourist.dart';

class Order {
  Hotel hotel;
  Room room;
  String phone;
  String email;
  List<Tourist> tourists;

  double get tourPrice => room.price;
  double get fuelSurcharge => room.price * 0.05;
  double get serviceSurcharge => room.price * 0.0115;
  double get totalPrice => room.price * 1.0615;

  Order({
    required this.hotel,
    required this.room,
    this.phone = '',
    this.email = '',
    this.tourists = const [],
  });
}
