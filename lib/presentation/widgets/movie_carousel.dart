import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MovieCarousel extends StatefulWidget {
  final List<String> imageUrls;

  const MovieCarousel({super.key, required this.imageUrls});

  @override
  State<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final carouselHeight = screenHeight * 0.55;
    final viewportFraction = screenWidth < 400 ? 0.7 : 0.55;

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.imageUrls.length,
          itemBuilder: (context, index, realIndex) {
            final isActive = index == _current;
            final imageUrl = widget.imageUrls[index];

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
              child: AspectRatio(
                aspectRatio: 2 / 3,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey.shade900,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.redAccent,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey.shade900,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.broken_image_rounded,
                            color: Colors.white38,
                            size: 48,
                          ),
                        ),
                      ),
                    ),

                    if (!isActive)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: carouselHeight,
            enlargeCenterPage: true,
            viewportFraction: viewportFraction,
            enlargeFactor: 0.25,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 6),
            onPageChanged: (index, reason) {
              if (!mounted) return;
              setState(() => _current = index);
            },
          ),
        ),
      ],
    );
  }
}
