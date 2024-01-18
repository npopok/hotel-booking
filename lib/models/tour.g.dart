// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tour _$TourFromJson(Map<String, dynamic> json) => Tour(
      id: json['id'] as int,
      hotelName: json['hotel_name'] as String,
      hotelAddress: json['hotel_adress'] as String,
      hotelRating: json['horating'] as int,
      ratingName: json['rating_name'] as String,
      departure: json['departure'] as String,
      arrival: json['arrival_country'] as String,
      startDate: json['tour_date_start'] as String,
      endDate: json['tour_date_stop'] as String,
      numberOfNights: json['number_of_nights'] as int,
      room: json['room'] as String,
      mealType: json['nutrition'] as String,
      tourPrice: (json['tour_price'] as num).toDouble(),
      fuelCharge: (json['fuel_charge'] as num).toDouble(),
      serviceCharge: (json['service_charge'] as num).toDouble(),
    );

Map<String, dynamic> _$TourToJson(Tour instance) => <String, dynamic>{
      'id': instance.id,
      'hotel_name': instance.hotelName,
      'hotel_adress': instance.hotelAddress,
      'horating': instance.hotelRating,
      'rating_name': instance.ratingName,
      'departure': instance.departure,
      'arrival_country': instance.arrival,
      'tour_date_start': instance.startDate,
      'tour_date_stop': instance.endDate,
      'number_of_nights': instance.numberOfNights,
      'room': instance.room,
      'nutrition': instance.mealType,
      'tour_price': instance.tourPrice,
      'fuel_charge': instance.fuelCharge,
      'service_charge': instance.serviceCharge,
    };
