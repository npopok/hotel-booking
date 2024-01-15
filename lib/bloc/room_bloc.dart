import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/service_api.dart';
import '../models/room.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomsApi roomsApi;

  RoomBloc(this.roomsApi) : super(RoomInitial()) {
    on<LoadRoomEvent>((event, emit) async {
      try {
        emit(RoomLoading());
        var rooms = await roomsApi.getRooms();
        emit(RoomLoaded(rooms));
      } catch (e) {
        emit(RoomError(e));
      }
    });
  }
}
