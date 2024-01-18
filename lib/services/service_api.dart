import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../models/hotel.dart';
import '../models/room.dart';
import '../models/tour.dart';

part 'service_api.g.dart';

@RestApi(baseUrl: 'https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473')
abstract class HotelsApi {
  factory HotelsApi(Dio dio, {String baseUrl}) = _HotelsApi;

  @GET('/')
  Future<Hotel> getHotel();
}

@RestApi(baseUrl: 'https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195')
abstract class RoomsApi {
  factory RoomsApi(Dio dio, {String baseUrl}) = _RoomsApi;

  @GET('/')
  Future<Rooms> getRooms();
}

@RestApi(baseUrl: 'https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff')
abstract class ToursApi {
  factory ToursApi(Dio dio, {String baseUrl}) = _ToursApi;

  @GET('/')
  Future<Tour> getTour();
}
