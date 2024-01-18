import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hotel_booking/widgets/feature_list.dart';

import '../bloc/room_bloc.dart';
import '../services/service_api.dart';
import '../models/room.dart';
import '../models/hotel.dart';
import "../screens/payment_screen.dart";
import '../widgets/navigation_button.dart';
import '../widgets/image_carousel.dart';
import '../widgets/price_info.dart';
import '../widgets/rounded_container.dart';
import '../widgets/not_implemented.dart';
import '../utils/value_formatter.dart';

class RoomScreen extends StatefulWidget {
  final Hotel hotel;

  const RoomScreen(this.hotel, {super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final roomBloc = RoomBloc(RoomsApi(Dio()));
  int selectedImage = 0;

  @override
  void initState() {
    roomBloc.add(LoadRoomEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.hotel.name)),
      ),
      body: BlocBuilder<RoomBloc, RoomState>(
        bloc: roomBloc,
        builder: (context, state) {
          if (state is RoomLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is RoomLoaded) {
            return _buildBody(state.rooms);
          }
          if (state is RoomError) {
            return Center(child: Text('ServerError'.tr()));
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildBody(Rooms rooms) {
    return SingleChildScrollView(
      child: Column(
        children: List<Widget>.generate(
          rooms.list.length,
          (index) => Column(
            children: [
              RoundedContainer(index == 0, _buildRoomDetails(rooms.list[index])),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoomDetails(Room room) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageCarousel(room.imageUrls),
        const SizedBox(height: 10),
        Text(room.name, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 5),
        FeatureList(room.features),
        const SizedBox(height: 10),
        _buildMoreDetails(),
        const SizedBox(height: 15),
        PriceInfo(
            'RoomScreen.PriceFormat'.tr(
              args: [ValueFormatter.formatMoney(room.price)],
            ),
            room.priceInfo),
        const SizedBox(height: 15),
        NavigationButton(
          title: 'RoomScreen.SelectRoom'.tr(),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PaymentScreen()),
          ),
        ),
      ],
    );
  }

  Widget _buildMoreDetails() {
    return InkWell(
      onTap: () => NotImplemented.showMessage(context),
      child: Container(
        padding: const EdgeInsets.only(left: 10, top: 2, bottom: 2, right: 5),
        height: 29,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xFF0D72FF).withOpacity(0.1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'RoomScreen.MoreDetails'.tr(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0D72FF),
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF0D72FF), size: 24),
          ],
        ),
      ),
    );
  }
}
