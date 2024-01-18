import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import '../models/tour.dart';
import '../models/order.dart';
import '../services/service_api.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final ToursApi toursApi;

  PaymentBloc(this.toursApi) : super(PaymentInitial()) {
    on<PaymentLoad>((event, emit) async {
      try {
        emit(PaymentLoading());
        var tour = await toursApi.getTour();
        emit(PaymentLoaded(tour));
      } catch (e) {
        emit(PaymentError(e));
      }
    });
    on<PaymentProcess>((event, emit) async {
      try {
        emit(PaymentProcessing());
        // Simulate call to external API
        await Future.delayed(const Duration(seconds: 2));
        emit(PaymentProcessed(Random().nextInt(1000)));
      } catch (e) {
        emit(PaymentError(e));
      }
    });
    on<PaymentReset>((event, emit) {
      emit(PaymentInitial());
    });
  }
}
