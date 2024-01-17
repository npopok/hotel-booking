part of 'payment_bloc.dart';

class PaymentEvent {}

class PaymentProcess extends PaymentEvent {
  final Order order;

  PaymentProcess(this.order);
}
