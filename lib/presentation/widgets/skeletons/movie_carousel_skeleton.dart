import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MovieCarouselSkeleton extends StatefulWidget {
  const MovieCarouselSkeleton({super.key});

  @override
  State<MovieCarouselSkeleton> createState() => _MovieCarouselSkeletonState();
}

class _MovieCarouselSkeletonState extends State<MovieCarouselSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final carouselHeight = screenHeight * 0.55;
    final viewportFraction = screenWidth < 400 ? 0.7 : 0.55;

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          width: screenWidth,
          height: screenHeight / 2.2,
          top: screenHeight / 27,
          child: Container(color: Colors.grey.shade900),
        ),

        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(color: Colors.black.withValues(alpha: 0.65)),
          ),
        ),

        CarouselSlider.builder(
          itemCount: 3,
          itemBuilder: (context, index, _) {
            return Column(
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 12,
                      ),
                      child: AspectRatio(
                        aspectRatio: 2 / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withValues(
                                alpha: 0.25 + (_controller.value * 0.2),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),

                // Year skeleton
                _skeletonLine(width: 50, height: 12),
                const SizedBox(height: 8),

                // Title skeleton
                _skeletonLine(width: 220, height: 20),
                const SizedBox(height: 12),

                // Tags row skeleton
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _skeletonChip(),
                    const SizedBox(width: 6),
                    _skeletonChip(),
                    const SizedBox(width: 6),
                    _skeletonChip(width: 50),
                  ],
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
          ),
        ),
      ],
    );
  }

  Widget _skeletonLine({required double width, required double height}) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(
              alpha: 0.25 + (_controller.value * 0.25),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
        );
      },
    );
  }

  Widget _skeletonChip({double width = 70}) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          width: width,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(
              alpha: 0.25 + (_controller.value * 0.25),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        );
      },
    );
  }
}
