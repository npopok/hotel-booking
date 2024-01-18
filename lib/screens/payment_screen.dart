import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../bloc/payment_bloc.dart';
import '../services/service_api.dart';
import '../models/tourist.dart';
import '../models/order.dart';
import '../models/tour.dart';
import '../screens/success_screen.dart';
import '../widgets/rating_bar.dart';
import '../widgets/navigation_button.dart';
import '../widgets/rounded_container.dart';
import '../widgets/simple_text_field.dart';
import '../widgets/date_text_field.dart';
import '../widgets/expandable_tile.dart';
import '../utils/value_formatter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final paymentBloc = PaymentBloc(ToursApi(Dio()));
  Tour? tour;
  String phone = '';
  String email = '';
  List<Tourist> tourists = [Tourist.empty()];
  bool isLoaded = false;
  bool isProcessing = false;
  final formKey = GlobalKey<FormState>();

  double totalPrice() {
    return tour!.tourPrice + tour!.fuelCharge + tour!.serviceCharge;
  }

  @override
  void initState() {
    paymentBloc.add(PaymentLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaymentScreen.Title').tr(),
      ),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        bloc: paymentBloc,
        builder: (context, state) {
          if (state is PaymentInitial) {
            paymentBloc.add(PaymentLoad());
            return Container();
          }
          if (state is PaymentLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PaymentLoaded) {
            tour = state.tour;
            if (!isLoaded) {
              // Temp hack to avoid infinite loop
              WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
            }
            isLoaded = true;
            return _buildBody();
          }
          if (state is PaymentProcessing) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PaymentProcessed) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SuccessScreen(state.orderId)),
              ).whenComplete(() {
                paymentBloc.add(PaymentReset());
                setState(() => isProcessing = false);
              }),
            );
            return Container();
          }
          if (state is PaymentError) {
            return Center(child: const Text('ServerError').tr());
          }
          return Container();
        },
      ),
      bottomNavigationBar: isLoaded && !isProcessing
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xFFE8E9EC)),
                  ),
                  color: Colors.white),
              child: NavigationButton(
                title: 'PaymentScreen.PayButton'.tr(
                  args: [ValueFormatter.formatMoney(totalPrice())],
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    var order = Order(
                      tour: tour!,
                      phone: phone,
                      email: email,
                      tourists: tourists,
                    );
                    paymentBloc.add(PaymentProcess(order));
                    setState(() => isProcessing = true);
                  }
                },
              ),
            )
          : null,
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
                tourists.length,
                (index) => Column(
                  children: [
                    RoundedContainer(
                      false,
                      _buildTouristDetails(index, tourists[index]),
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
          tour!.hotelRating,
          tour!.ratingName,
        ),
        const SizedBox(height: 5),
        Text(
          tour!.hotelName,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 5),
        Text(
          tour!.hotelAddress,
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
          tour!.departure,
        ),
        const SizedBox(height: 10),
        _buildTripDetailsRow(
          'PaymentScreen.Arrival'.tr(),
          tour!.arrival,
        ),
        const SizedBox(height: 10),
        _buildTripDetailsRow(
          'PaymentScreen.Dates'.tr(),
          '${tour!.startDate} - ${tour!.endDate}',
        ),
        const SizedBox(height: 10),
        _buildTripDetailsRow(
          'PaymentScreen.Nights'.tr(),
          tour!.numberOfNights.toString(),
        ),
        const SizedBox(height: 10),
        _buildTripDetailsRow(
          'PaymentScreen.Hotel'.tr(),
          tour!.hotelName,
        ),
        const SizedBox(height: 10),
        _buildTripDetailsRow(
          'PaymentScreen.Room'.tr(),
          tour!.room,
        ),
        const SizedBox(height: 10),
        _buildTripDetailsRow(
          'PaymentScreen.Meal'.tr(),
          tour!.mealType,
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
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 15),
        SimpleTextField(
          type: TextFieldType.phone,
          label: 'PhoneTextField.Label'.tr(),
          hint: 'PhoneTextField.Hint'.tr(),
          onSaved: (value) => phone = value!,
        ),
        const SizedBox(height: 10),
        SimpleTextField(
          type: TextFieldType.email,
          label: 'EmailTextField.Label'.tr(),
          onSaved: (value) => email = value!,
        ),
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
          type: TextFieldType.text,
          label: 'PaymentScreen.FirstName'.tr(),
          minLength: 2,
          onSaved: (value) => tourist.firstName = value!,
        ),
        const SizedBox(height: 10),
        SimpleTextField(
          type: TextFieldType.text,
          label: 'PaymentScreen.LastName'.tr(),
          minLength: 2,
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
          type: TextFieldType.text,
          label: 'PaymentScreen.Citizenship'.tr(),
          minLength: 2,
          onSaved: (value) => tourist.citizenship = value!,
        ),
        const SizedBox(height: 10),
        SimpleTextField(
          type: TextFieldType.number,
          label: 'PaymentScreen.PassportNumber'.tr(),
          minLength: 9,
          maxLength: 9,
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
              style: Theme.of(context).textTheme.titleLarge,
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
              onPressed: () => setState(() {
                if (tourists.length < 5) {
                  tourists.add(Tourist.empty());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('PaymentScreen.TouristLimit'.tr()),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                }
              }),
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
    return Column(children: [
      _buildPaymentSummaryRow(
        'PaymentScreen.Tour'.tr(),
        'PaymentScreen.PriceFormat'.tr(
          args: [ValueFormatter.formatMoney(tour!.tourPrice)],
        ),
      ),
      const SizedBox(height: 10),
      _buildPaymentSummaryRow(
        'PaymentScreen.FuelSurcharge'.tr(),
        'PaymentScreen.PriceFormat'.tr(
          args: [ValueFormatter.formatMoney(tour!.fuelCharge)],
        ),
      ),
      const SizedBox(height: 10),
      _buildPaymentSummaryRow(
        'PaymentScreen.ServiceSurcharge'.tr(),
        'PaymentScreen.PriceFormat'.tr(
          args: [ValueFormatter.formatMoney(tour!.serviceCharge)],
        ),
      ),
      const SizedBox(height: 10),
      _buildPaymentSummaryRow(
        'PaymentScreen.TotalPrice'.tr(),
        'PaymentScreen.PriceFormat'.tr(
          args: [ValueFormatter.formatMoney(totalPrice())],
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
