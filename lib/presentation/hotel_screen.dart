import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:intl/intl.dart';

import '../bloc/hotel_bloc.dart';
import '../services/service_api.dart';
import '../models/hotel.dart';
import '../presentation/navigation_button.dart';
import '../presentation/room_screen.dart';

class HotelSceeen extends StatefulWidget {
  static const routeName = '/hotel';

  const HotelSceeen({super.key});

  @override
  State<HotelSceeen> createState() => _HotelSceeenState();
}

class _HotelSceeenState extends State<HotelSceeen> {
  final hotelBloc = HotelBloc(HotelsApi(Dio()));
  int selectedImage = 0;

  String formatMoney(double money) {
    return NumberFormat("#,###", "en_US").format(money).replaceAll(',', ' ');
  }

  @override
  void initState() {
    hotelBloc.add(LoadHotelEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Отель"))),
      backgroundColor: const Color(0xF0F6F6F9),
      body: BlocBuilder<HotelBloc, HotelState>(
          bloc: hotelBloc,
          builder: (context, state) {
            if (state is HotelLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HotelLoaded) {
              return _buildBody(state.hotel);
            }
            if (state is HotelError) {
              return const Center(child: Text('Ошибка сервера. Попробуйте позже.'));
            }
            return Container();
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: NavigationButton('К выбору номера', (_) => const RoomScreen())),
    );
  }

  Widget _buildBody(Hotel hotel) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                color: Colors.white),
            child: _buildTourDetails(hotel),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
            child: _buildHotelDetails(hotel),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildTourDetails(Hotel hotel) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          children: [
            _buildImageCarousel(hotel.imageUrls),
            Positioned.fill(
                bottom: 10,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildSmoothIndicator(hotel.imageUrls.length, selectedImage),
                )),
          ],
        ),
        const SizedBox(height: 10),
        _buildRatingBar(hotel.rating, hotel.ratingName),
        const SizedBox(height: 5),
        Text(hotel.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
        const SizedBox(height: 5),
        Text(
          hotel.address,
          style:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF0D72FF)),
        ),
        const SizedBox(height: 10),
        RichText(
            text: TextSpan(
                text: 'От ${formatMoney(hotel.minPrice)} ₽ ',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.black),
                children: [
              TextSpan(
                  text: hotel.priceInfo,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF828796))),
            ])),
      ]),
    );
  }

  Widget _buildImageCarousel(List<String> imageUrls) {
    return CarouselSlider.builder(
      itemCount: imageUrls.length,
      itemBuilder: (_, index, __) => Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Image.network(imageUrls[index],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 32)),
      ),
      options: CarouselOptions(
        height: 257,
        aspectRatio: 1.33,
        viewportFraction: 1,
        onPageChanged: (index, _) => setState(() => (selectedImage = index)),
      ),
    );
  }

  Widget _buildSmoothIndicator(int count, int activeIndex) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: count,
        effect: const SlideEffect(
            spacing: 5,
            radius: 5,
            dotWidth: 10,
            dotHeight: 10,
            paintStyle: PaintingStyle.fill,
            strokeWidth: 1.5,
            dotColor: Colors.black26,
            activeDotColor: Colors.black),
      ),
    );
  }

  Widget _buildRatingBar(int rating, String ratingName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFFC700).withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: Color(0xFFFFA800), size: 20),
            Text('$rating $ratingName',
                style: const TextStyle(
                    color: Color(0xFFFFA800), fontSize: 16, fontWeight: FontWeight.w500))
          ]),
    );
  }

  Widget _buildHotelDetails(Hotel hotel) {
    return Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Об отеле', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          _buildHotelFeatures(hotel),
          const SizedBox(height: 10),
          Text(hotel.about.description,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black.withOpacity(0.9))),
          const SizedBox(height: 10),
          _buildWhatsIncluded(),
        ]));
  }

  Widget _buildHotelFeatures(Hotel hotel) {
    return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List<Container>.generate(
            hotel.about.features.length,
            (index) => Container(
                  padding: const EdgeInsets.all(5),
                  color: const Color(0xFFFBFBFC),
                  child: Text(
                    hotel.about.features[index],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF828796)),
                  ),
                )));
  }

  Widget _buildWhatsIncluded() {
    return ListView(
      shrinkWrap: true,
      children: [
        _buildWhatsIncludedTile(Icons.mood, 24, 'Удобства', 'Самое необходимое'),
        _buildWhatsIncludedTile(
            Icons.check_circle_outline, 24, 'Что включено', 'Самое необходимое'),
        _buildWhatsIncludedTile(Icons.highlight_off, 24, 'Что не включено', 'Самое необходимое'),
      ],
    );
  }

  ListTile _buildWhatsIncludedTile(IconData icon, double iconSize, String title, String subtitle) {
    return ListTile(
      visualDensity: const VisualDensity(vertical: -3),
      leading: Icon(icon, size: iconSize),
      title: Text(title,
          style:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF2C3035))),
      subtitle: Text(subtitle,
          style:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF828796))),
      trailing: const Icon(
        Icons.chevron_right,
        color: Color(0xFF2C3035),
      ),
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Не реализовано.'),
        duration: Duration(seconds: 1),
      )),
    );
  }
}
