import '../models/tour.dart';
import '../models/tourist.dart';

class Order {
  final Tour tour;
  final String phone;
  final String email;
  final List<Tourist> tourists;

  const Order({
    required this.tour,
    required this.phone,
    required this.email,
    required this.tourists,
  });
}
