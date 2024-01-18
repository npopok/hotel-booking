part of 'payment_bloc.dart';

class PaymentEvent {}

class PaymentLoad extends PaymentEvent {}

class PaymentProcess extends PaymentEvent {
  final Order order;
  PaymentProcess(this.order);
}

class PaymentReset extends PaymentEvent {}
