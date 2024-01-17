import '../models/hotel.dart';
import '../models/room.dart';
import '../models/tourist.dart';

class Order {
  Hotel hotel;
  Room room;
  String phone;
  String email;
  List<Tourist> tourists;

  Order({
    required this.hotel,
    required this.room,
    this.phone = '',
    this.email = '',
    this.tourists = const [],
  });
}
