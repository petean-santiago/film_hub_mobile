import 'package:flutter/material.dart';

class MovieCategoryListSkeleton extends StatefulWidget {
  const MovieCategoryListSkeleton({super.key});

  @override
  State<MovieCategoryListSkeleton> createState() =>
      _MovieCategoryListSkeletonState();
}

class _MovieCategoryListSkeletonState extends State<MovieCategoryListSkeleton>
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
    final screenWidth = MediaQuery.of(context).size.width;
    final itemHeight = screenWidth * 0.5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: _skeletonLine(width: 160, height: 20),
        ),

        SizedBox(
          height: itemHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (_, __) {
              return AspectRatio(
                aspectRatio: 2 / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (_, __) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(
                            alpha: 0.25 + (_controller.value * 0.25),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
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
}
