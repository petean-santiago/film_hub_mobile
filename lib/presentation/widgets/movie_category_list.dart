import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MovieCategoryList extends StatelessWidget {
  final String categoryTitle;
  final List<String> imageUrls;
  final bool useCarousel;

  const MovieCategoryList({
    super.key,
    required this.categoryTitle,
    required this.imageUrls,
    this.useCarousel = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            categoryTitle,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 0.5,
            ),
          ),
        ),

        if (!useCarousel)
          SizedBox(
            height: screenWidth * 0.5,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: imageUrls.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: Image.network(
                      imageUrls[index],
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) =>
                          progress == null
                          ? child
                          : Container(
                              color: Colors.grey.shade900,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey.shade900,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.broken_image_rounded,
                          color: Colors.white38,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        else
          CarouselSlider.builder(
            itemCount: imageUrls.length,
            itemBuilder: (context, index, _) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrls[index],
                  fit: BoxFit.cover,
                  width: screenWidth * 0.35,
                ),
              );
            },
            options: CarouselOptions(
              height: screenWidth * 0.5,
              viewportFraction: 0.35,
              enableInfiniteScroll: false,
              padEnds: false,
            ),
          ),
      ],
    );
  }
}
