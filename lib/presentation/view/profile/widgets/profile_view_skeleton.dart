import 'dart:ui';
import 'package:flutter/material.dart';

class ProfileViewSkeleton extends StatefulWidget {
  const ProfileViewSkeleton({super.key});

  @override
  State<ProfileViewSkeleton> createState() => _ProfileViewSkeletonState();
}

class _ProfileViewSkeletonState extends State<ProfileViewSkeleton>
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

  Color get _color =>
      Colors.grey.withValues(alpha: 0.25 + (_controller.value * 0.25));

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// Fake blurred background
          Positioned.fill(child: Container(color: Colors.black)),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(color: Colors.black.withValues(alpha: 0.45)),
            ),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              children: [
                /// AVATAR
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: _color,
                    shape: BoxShape.circle,
                  ),
                ),

                const SizedBox(height: 20),

                /// USERNAME
                Container(
                  width: 140,
                  height: 22,
                  decoration: BoxDecoration(
                    color: _color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 8),

                /// COUNTRY
                Container(
                  width: 60,
                  height: 12,
                  decoration: BoxDecoration(
                    color: _color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),

                const SizedBox(height: 25),

                /// STATS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [_stat(), _stat(), _stat()],
                ),

                const SizedBox(height: 30),

                /// GLASS CARDS
                _glass(width),
                const SizedBox(height: 12),
                _glass(width),
                const SizedBox(height: 12),
                _glass(width),

                const SizedBox(height: 20),

                /// LOGOUT
                Container(
                  width: width,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat() {
    return Column(
      children: [
        Container(
          width: 28,
          height: 20,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 60,
          height: 10,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ],
    );
  }

  Widget _glass(double width) {
    return Container(
      width: width,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
    );
  }
}
