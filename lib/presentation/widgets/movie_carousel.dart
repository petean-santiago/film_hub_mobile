import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../view/shared/movie_detail_view.dart';

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

    final backgroundImage = widget.imageUrls[_current];

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          width: screenWidth,
          height: screenHeight / 2.2,
          top: screenHeight / 27,
          child: Image.network(
            backgroundImage,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: Colors.black),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(color: Colors.black.withValues(alpha: 0.65)),
          ),
        ),

        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CarouselSlider.builder(
              itemCount: widget.imageUrls.length,
              itemBuilder: (context, index, realIndex) {
                final isActive = index == _current;
                final imageUrl = widget.imageUrls[index];

                return Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      curve: Curves.easeOut,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 12,
                      ),
                      child: AspectRatio(
                        aspectRatio: 2 / 3,
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MovieDetailView(
                                      imageUrl: backgroundImage,
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'image-poster-$index',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Container(
                                            color: Colors.grey.shade900,
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          );
                                        },
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
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
                    ),

                    if (isActive)
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Column(
                          children: [
                            const Text(
                              "2010",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                            const Text(
                              "Matrix",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 5,
                              children: [
                                _buildTag("Fantasy"),
                                _buildTag("1h 40min"),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.07),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Row(
                                    spacing: 5,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.solidStar,
                                        size: 14,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        "9.2",
                                        style: TextStyle(
                                          color: Colors.amber,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
              options: CarouselOptions(
                height: carouselHeight + 100,
                enlargeCenterPage: true,
                viewportFraction: viewportFraction,
                enlargeFactor: 0.25,
                autoPlay: false,
                onPageChanged: (index, reason) {
                  if (!mounted) return;
                  setState(() => _current = index);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
