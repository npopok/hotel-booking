import 'package:json_annotation/json_annotation.dart';

part 'hotel.g.dart';

@JsonSerializable()
class HotelAbout {
  String description;
  @JsonKey(name: 'peculiarities')
  List<String> features;

  HotelAbout({required this.description, required this.features});

  factory HotelAbout.fromJson(Map<String, dynamic> json) => _$HotelAboutFromJson(json);
  Map<String, dynamic> toJson() => _$HotelAboutToJson(this);
}

@JsonSerializable()
class Hotel {
  int id;
  String name;
  @JsonKey(name: 'adress')
  String address;
  @JsonKey(name: 'minimal_price')
  double minPrice;
  @JsonKey(name: 'price_for_it')
  String priceInfo;
  int rating;
  @JsonKey(name: 'rating_name')
  String ratingName;
  @JsonKey(name: 'image_urls')
  List<String> imageUrls;
  @JsonKey(name: 'about_the_hotel')
  HotelAbout about;

  Hotel(
      {required this.id,
      required this.name,
      required this.address,
      required this.minPrice,
      required this.priceInfo,
      required this.rating,
      required this.ratingName,
      required this.imageUrls,
      required this.about});

  factory Hotel.fromJson(Map<String, dynamic> json) => _$HotelFromJson(json);
  Map<String, dynamic> toJson() => _$HotelToJson(this);
}
