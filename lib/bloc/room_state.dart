part of 'room_bloc.dart';

class RoomState {}

class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

class RoomLoaded extends RoomState {
  final Rooms rooms;
  RoomLoaded(this.rooms);
}

class RoomError extends RoomState {
  final Object? error;
  RoomError(this.error);
}
