part of 'payment_bloc.dart';

class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final Tour tour;
  PaymentLoaded(this.tour);
}

class PaymentProcessing extends PaymentState {}

class PaymentProcessed extends PaymentState {
  final int orderId;
  PaymentProcessed(this.orderId);
}

class PaymentError extends PaymentState {
  final Object? error;
  PaymentError(this.error);
}
