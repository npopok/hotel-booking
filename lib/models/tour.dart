import 'package:json_annotation/json_annotation.dart';

part 'tour.g.dart';

@JsonSerializable()
class Tour {
  int id;
  @JsonKey(name: 'hotel_name')
  String hotelName;
  @JsonKey(name: 'hotel_adress')
  String hotelAddress;
  @JsonKey(name: 'horating')
  int hotelRating;
  @JsonKey(name: 'rating_name')
  String ratingName;
  String departure;
  @JsonKey(name: 'arrival_country')
  String arrival;
  @JsonKey(name: 'tour_date_start')
  String startDate;
  @JsonKey(name: 'tour_date_stop')
  String endDate;
  @JsonKey(name: 'number_of_nights')
  int numberOfNights;
  String room;
  @JsonKey(name: 'nutrition')
  String mealType;
  @JsonKey(name: 'tour_price')
  double tourPrice;
  @JsonKey(name: 'fuel_charge')
  double fuelCharge;
  @JsonKey(name: 'service_charge')
  double serviceCharge;

  Tour(
      {required this.id,
      required this.hotelName,
      required this.hotelAddress,
      required this.hotelRating,
      required this.ratingName,
      required this.departure,
      required this.arrival,
      required this.startDate,
      required this.endDate,
      required this.numberOfNights,
      required this.room,
      required this.mealType,
      required this.tourPrice,
      required this.fuelCharge,
      required this.serviceCharge});

  factory Tour.fromJson(Map<String, dynamic> json) => _$TourFromJson(json);
  Map<String, dynamic> toJson() => _$TourToJson(this);
}
