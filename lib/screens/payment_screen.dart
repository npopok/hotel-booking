import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../bloc/payment_bloc.dart';
import '../models/hotel.dart';
import '../models/room.dart';
import '../models/tourist.dart';
import '../models/order.dart';
import '../screens/success_screen.dart';
import '../widgets/rating_bar.dart';
import '../widgets/navigation_button.dart';
import '../widgets/rounded_container.dart';
import '../widgets/phone_text_field.dart';
import '../widgets/email_text_field.dart';
import '../widgets/simple_text_field.dart';
import '../widgets/date_text_field.dart';
import '../widgets/expandable_tile.dart';
import '../utils/value_formatter.dart';

class PaymentScreen extends StatefulWidget {
  Order order;

  PaymentScreen(Hotel hotel, Room room, {super.key})
      : order = Order(
          hotel: hotel,
          room: room,
          tourists: [Tourist.empty()],
        );

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final paymentBloc = PaymentBloc();
  bool isProcessing = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PaymentScreen.Title').tr()),
      backgroundColor: const Color(0xF0F6F6F9),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        bloc: paymentBloc,
        builder: (context, state) {
          if (state is PaymentInitial) {
            return _buildBody();
          }
          if (state is PaymentProcessing) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PaymentProcessed) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SuccessScreen(state.orderId)),
                (_) => false,
              );
            });
          }
          if (state is PaymentError) {
            return Center(child: const Text('ServerError').tr());
          }
          return Container();
        },
      ),
      bottomNavigationBar: Visibility(
        visible: !isProcessing,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFFE8E9EC)),
              ),
              color: Colors.white),
          child: NavigationButton(
            title: 'PaymentScreen.PayButton'.tr(
              args: [ValueFormatter.formatMoney(widget.order.room.price)],
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                paymentBloc.add(PaymentProcess(widget.order));
                setState(() => isProcessing = true);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
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
              children: List<Widget>.generate(
                widget.order.tourists.length,
                (index) => Column(
                  children: [
                    RoundedContainer(
                      false,
                      _buildTouristDetails(index, widget.order.tourists[index]),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            _buildAddTourist(),
            const SizedBox(height: 10),
            RoundedContainer(false, _buildPaymentSummary()),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildHotelDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingBar(
          widget.order.hotel.rating,
          widget.order.hotel.ratingName,
        ),
        const SizedBox(height: 5),
        Text(
          widget.order.hotel.name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        Text(
          widget.order.hotel.address,
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
        _buildTripDetailsRow(
          'PaymentScreen.Departure'.tr(),
          'PaymentScreen.Dummy1'.tr(),
        ),
        const SizedBox(height: 10),
        _buildTripDetailsRow(
          'PaymentScreen.Destination'.tr(),
          'PaymentScreen.Dummy2'.tr(),
        ),
        const SizedBox(height: 10),
        _buildTripDetailsRow(
          'PaymentScreen.Dates'.tr(),
          'PaymentScreen.Dummy3'.tr(),
        ),
        const SizedBox(height: 10),
        _buildTripDetailsRow(
          'PaymentScreen.Nights'.tr(),
          'PaymentScreen.Dummy4'.tr(),
        ),
        const SizedBox(height: 10),
        _buildTripDetailsRow(
          'PaymentScreen.Hotel'.tr(),
          widget.order.hotel.name,
        ),
        const SizedBox(height: 10),
        _buildTripDetailsRow(
          'PaymentScreen.Room'.tr(),
          widget.order.room.name,
        ),
        const SizedBox(height: 10),
        _buildTripDetailsRow(
          'PaymentScreen.Meal'.tr(),
          'PaymentScreen.Dummy5'.tr(),
        ),
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
        Text(
          'PaymentScreen.ContactInfo'.tr(),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        PhoneTextField(onSaved: (value) => widget.order.phone = value!),
        const SizedBox(height: 10),
        EmailTextField(onSaved: (value) => widget.order.email = value!),
        const SizedBox(height: 10),
        Text(
          'PaymentScreen.DataDisclaimer'.tr(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF828796),
          ),
        )
      ],
    );
  }

  Widget _buildTouristDetails(int index, Tourist tourist) {
    return ExpandableTile(
      title: 'PaymentScreen.Tourist${index + 1}'.tr(),
      children: [
        const SizedBox(height: 10),
        SimpleTextField(
          label: 'PaymentScreen.FirstName'.tr(),
          onSaved: (value) => tourist.firstName = value!,
        ),
        const SizedBox(height: 10),
        SimpleTextField(
          label: 'PaymentScreen.LastName'.tr(),
          onSaved: (value) => tourist.lastName = value!,
        ),
        const SizedBox(height: 10),
        DateTextField(
          label: 'PaymentScreen.DateOfBirth'.tr(),
          minDate: DateTime.now().subtract(const Duration(days: 366 * 100)),
          maxDate: DateTime.now(),
          onSaved: (date) => tourist.dateOfBirth = date,
        ),
        const SizedBox(height: 10),
        SimpleTextField(
          label: 'PaymentScreen.Citizenship'.tr(),
          onSaved: (value) => tourist.citizenship = value!,
        ),
        const SizedBox(height: 10),
        SimpleTextField(
          label: 'PaymentScreen.PassportNumber'.tr(),
          onSaved: (value) => tourist.passportNumber = value!,
        ),
        const SizedBox(height: 10),
        DateTextField(
          label: 'PaymentScreen.PassportExpires'.tr(),
          minDate: DateTime.now(),
          maxDate: DateTime.now().add(const Duration(days: 366 * 10)),
          onSaved: (date) => tourist.passportExpires = date,
        ),
      ],
    );
  }

  Widget _buildAddTourist() {
    return RoundedContainer(
      false,
      Row(
        children: [
          Expanded(
            child: Text(
              'PaymentScreen.AddTourist'.tr(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
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
                () => widget.order.tourists.add(Tourist.empty()),
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

  Widget _buildPaymentSummary() {
    double tourPrice = widget.order.room.price;
    double fuelSurcharge = widget.order.room.price * 0.05;
    double serviceSurcharge = widget.order.room.price * 0.0115;
    double totalPrice = tourPrice + fuelSurcharge + serviceSurcharge;

    return Column(children: [
      _buildPaymentSummaryRow(
        'PaymentScreen.Tour'.tr(),
        'PaymentScreen.PriceFormat'.tr(
          args: [ValueFormatter.formatMoney(tourPrice)],
        ),
      ),
      const SizedBox(height: 10),
      _buildPaymentSummaryRow(
        'PaymentScreen.FuelSurcharge'.tr(),
        'PaymentScreen.PriceFormat'.tr(
          args: [ValueFormatter.formatMoney(fuelSurcharge)],
        ),
      ),
      const SizedBox(height: 10),
      _buildPaymentSummaryRow(
        'PaymentScreen.ServiceSurcharge'.tr(),
        'PaymentScreen.PriceFormat'.tr(
          args: [ValueFormatter.formatMoney(serviceSurcharge)],
        ),
      ),
      const SizedBox(height: 10),
      _buildPaymentSummaryRow(
        'PaymentScreen.TotalPrice'.tr(),
        'PaymentScreen.PriceFormat'.tr(
          args: [ValueFormatter.formatMoney(totalPrice)],
        ),
        totalPrice: true,
      ),
    ]);
  }

  Widget _buildPaymentSummaryRow(String leftText, String rightText, {bool totalPrice = false}) {
    return Row(
      children: [
        SizedBox(
          width: 200,
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
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 16,
              fontWeight: totalPrice ? FontWeight.w600 : FontWeight.w400,
              color: totalPrice ? const Color(0xFF0D72FF) : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
