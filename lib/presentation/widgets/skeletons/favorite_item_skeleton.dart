import 'dart:ui';
import 'package:flutter/material.dart';

class FavoriteItemCardSkeleton extends StatefulWidget {
  const FavoriteItemCardSkeleton({super.key});

  @override
  State<FavoriteItemCardSkeleton> createState() =>
      _FavoriteItemCardSkeletonState();
}

class _FavoriteItemCardSkeletonState extends State<FavoriteItemCardSkeleton>
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

  double get shimmer => 0.2 + (_controller.value * 0.25); // shimmer intensity

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ✅ POSTER SKELETON (100x150)
              AnimatedBuilder(
                animation: _controller,
                builder: (_, __) {
                  return Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: shimmer),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                    ),
                  );
                },
              ),

              /// ✅ TEXT AREA SKELETON
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// TITLE
                      _skeletonLine(width: 160, height: 18),
                      const SizedBox(height: 10),

                      /// DESCRIPTION (3 lines)
                      _skeletonLine(width: double.infinity, height: 12),
                      const SizedBox(height: 6),
                      _skeletonLine(width: double.infinity, height: 12),
                      const SizedBox(height: 6),
                      _skeletonLine(width: 120, height: 12),

                      const SizedBox(height: 14),

                      /// TAGS
                      Row(
                        children: [
                          _skeletonChip(width: 60),
                          const SizedBox(width: 8),
                          _skeletonChip(width: 50),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
            color: Colors.grey.withValues(alpha: shimmer),
            borderRadius: BorderRadius.circular(6),
          ),
        );
      },
    );
  }

  Widget _skeletonChip({required double width}) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          width: width,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: shimmer),
            borderRadius: BorderRadius.circular(20),
          ),
        );
      },
    );
  }
}
