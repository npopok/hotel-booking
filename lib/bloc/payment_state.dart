part of 'payment_bloc.dart';

class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentProcessing extends PaymentState {}

class PaymentProcessed extends PaymentState {
  final int orderId;
  PaymentProcessed(this.orderId);
}

class PaymentError extends PaymentState {
  final Object? error;
  PaymentError(this.error);
}
