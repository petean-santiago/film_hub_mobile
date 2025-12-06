import 'dart:ui';
import 'package:flutter/material.dart';

import 'favorite_item_skeleton.dart';

class FavoritesViewSkeleton extends StatelessWidget {
  const FavoritesViewSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Fake blurred background
        Positioned.fill(child: Container(color: Colors.black)),

        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(color: Colors.black.withValues(alpha: 0.45)),
          ),
        ),

        CustomScrollView(
          slivers: [
            /// FAKE APPBAR
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Container(
                  width: 160,
                  height: 26,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            /// LIST
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 90),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: FavoriteItemCardSkeleton(),
                  );
                }, childCount: 6),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
