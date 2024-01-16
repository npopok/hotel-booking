import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/hotel.dart';
import '../models/room.dart';
import '../models/tourist.dart';
import '../screens/success_screen.dart';
import '../widgets/rating_bar.dart';
import '../widgets/navigation_button.dart';
import '../widgets/rounded_container.dart';
import '../widgets/phone_text_field.dart';
import '../widgets/email_text_field.dart';
import '../utils/formatter.dart';

class PaymentScreen extends StatefulWidget {
  final Hotel hotel;
  final Room room;

  const PaymentScreen(this.hotel, this.room, {super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<Tourist> tourists = [Tourist.empty()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PaymentScreen.Title').tr()),
      backgroundColor: const Color(0xF0F6F6F9),
      body: _buildBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 16),
      //   child: NavigationButton(
      //     'Оплатить ${Formatter.formatMoney(room.price)} ₽',
      //     (_) => const SuccessScreen(),
      //   ),
      // ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(children: [
            RoundedContainer(true, _buildHotelDetails()),
            const SizedBox(height: 10),
            RoundedContainer(false, _buildTripDetails()),
            const SizedBox(height: 10),
            RoundedContainer(false, _buildContactInfo()),
            const SizedBox(height: 10),
          ]),
          Column(
            children: List<RoundedContainer>.generate(
              tourists.length,
              (index) => RoundedContainer(
                false,
                _buildTouristDetails(index, tourists[index]),
              ),
            ),
          ),
          _buildAddTourist(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHotelDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingBar(widget.hotel.rating, widget.hotel.ratingName),
        const SizedBox(height: 5),
        Text(
          widget.hotel.name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        Text(
          widget.hotel.address,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF0D72FF),
          ),
        ),
      ],
    );
  }

  Widget _buildTripDetails() {
    return Column(
      children: [
        _buildTripDetailsRow('Вылет из', 'Новосибирск'),
        const SizedBox(height: 10),
        _buildTripDetailsRow('Страна, город', 'Египет, Хургада'),
        const SizedBox(height: 10),
        _buildTripDetailsRow('Даты', '19.03.2024 - 27.03.2024'),
        const SizedBox(height: 10),
        _buildTripDetailsRow('Кол-во ночей', '7 ночей'),
        const SizedBox(height: 10),
        _buildTripDetailsRow('Отель', widget.hotel.name),
        const SizedBox(height: 10),
        _buildTripDetailsRow('Номер', widget.room.name),
        const SizedBox(height: 10),
        _buildTripDetailsRow('Питание', 'Все включено'),
      ],
    );
  }

  Widget _buildTripDetailsRow(String leftText, String rightText) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: Text(
            leftText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF828796),
            ),
          ),
        ),
        Expanded(
          child: Text(
            rightText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Информация о покупателе',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        const PhoneTextField(),
        const SizedBox(height: 10),
        const EmailTextField(),
        const SizedBox(height: 10),
        Text(
          'Эти данные никому не передаются. После оплаты мы вышлем чек на указанный вами номер и почту.',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF828796),
          ),
        )
      ],
    );
  }

  Widget _buildTouristDetails(int index, Tourist tourist) {
    return RoundedContainer(
      false,
      Text(
        'Добавить туриста',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildAddTourist() {
    return RoundedContainer(
      false,
      Row(
        children: [
          const Expanded(
            child: Text(
              'Добавить туриста',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xFF0D72FF),
            ),
            child: IconButton(
              onPressed: () => setState(
                () => tourists.add(Tourist.empty()),
              ),
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.add, size: 24),
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
