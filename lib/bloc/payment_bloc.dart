import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import '../models/order.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<PaymentProcess>((event, emit) async {
      try {
        emit(PaymentProcessing());
        await Future.delayed(const Duration(seconds: 5));
        emit(PaymentProcessed(Random().nextInt(1000)));
      } catch (e) {
        emit(PaymentError(e));
      }
    });
  }
}
