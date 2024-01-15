import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/models/hotel.dart';

import '../services/service_api.dart';

part 'hotel_event.dart';
part 'hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final HotelsApi hotelsApi;

  HotelBloc(this.hotelsApi) : super(HotelInitial()) {
    on<LoadHotelEvent>((event, emit) async {
      try {
        emit(HotelLoading());
        var hotel = await hotelsApi.getHotel();
        sleep(Duration(seconds: 3));
        emit(HotelLoaded(hotel));
      } catch (e) {
        emit(HotelError(e));
      }
    });
  }
}
