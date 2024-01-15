import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> imageUrls;

  const ImageCarousel(this.imageUrls, {super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildImageCarousel(widget.imageUrls),
        Positioned.fill(
            bottom: 10,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _buildSmoothIndicator(widget.imageUrls.length, selectedImage),
            )),
      ],
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
            dotWidth: 7,
            dotHeight: 7,
            paintStyle: PaintingStyle.fill,
            strokeWidth: 1.5,
            dotColor: Colors.black26,
            activeDotColor: Colors.black),
      ),
    );
  }
}
