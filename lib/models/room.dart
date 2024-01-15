import 'package:json_annotation/json_annotation.dart';

part 'room.g.dart';

@JsonSerializable()
class Room {
  int id;
  String name;
  double price;
  @JsonKey(name: 'price_per')
  String priceInfo;
  @JsonKey(name: 'peculiarities')
  List<String> features;
  @JsonKey(name: 'image_urls')
  List<String> imageUrls;

  Room(
      {required this.id,
      required this.name,
      required this.price,
      required this.priceInfo,
      required this.features,
      required this.imageUrls});

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
  Map<String, dynamic> toJson() => _$RoomToJson(this);
}

@JsonSerializable()
class Rooms {
  @JsonKey(name: 'rooms')
  List<Room> list;

  Rooms({required this.list});

  factory Rooms.fromJson(Map<String, dynamic> json) => _$RoomsFromJson(json);
  Map<String, dynamic> toJson() => _$RoomsToJson(this);
}
