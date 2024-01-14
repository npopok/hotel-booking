// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelAbout _$HotelAboutFromJson(Map<String, dynamic> json) => HotelAbout(
      description: json['description'] as String,
      features: (json['peculiarities'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$HotelAboutToJson(HotelAbout instance) =>
    <String, dynamic>{
      'description': instance.description,
      'peculiarities': instance.features,
    };

Hotel _$HotelFromJson(Map<String, dynamic> json) => Hotel(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['adress'] as String,
      minPrice: (json['minimal_price'] as num).toDouble(),
      priceInfo: json['price_for_it'] as String,
      rating: json['rating'] as int,
      ratingName: json['rating_name'] as String,
      imageUrls: (json['image_urls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      about:
          HotelAbout.fromJson(json['about_the_hotel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HotelToJson(Hotel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'adress': instance.address,
      'minimal_price': instance.minPrice,
      'price_for_it': instance.priceInfo,
      'rating': instance.rating,
      'rating_name': instance.ratingName,
      'image_urls': instance.imageUrls,
      'about_the_hotel': instance.about,
    };
