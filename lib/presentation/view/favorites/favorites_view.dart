import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:film_hub/presentation/widgets/custom_silver_app_bar.dart';
import '../../widgets/favorite_item_card.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final List<Map<String, dynamic>> favorites = [
    {
      'title': 'Breaking Bad',
      'poster':
          'https://image.tmdb.org/t/p/w500/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
      'genres': ['Drama', 'Crime'],
      'description': 'A chemistry teacher turned methamphetamine producer.',
    },
    {
      'title': 'Spirited Away',
      'poster':
          'https://image.tmdb.org/t/p/w500/oRvMaJOmapypFUcQqpgHMZA6qL9.jpg',
      'genres': ['Fantasy', 'Animation'],
      'description': 'A girl enters a magical world ruled by spirits.',
    },
  ];

  final List<String> filters = ["All", "Movies", "Series"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Transform.rotate(
              angle: 3.14159,
              child: Image.network(
                "https://t3.ftcdn.net/jpg/06/52/50/84/360_F_652508416_PMVJMXZMgnpHmlUIoEnV6xlSTojSwiQ3.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(color: Colors.black.withValues(alpha: 0.55)),
            ),
          ),

          ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: CustomScrollView(
              slivers: [
                CustomSilverAppBar(filters: filters, showFilters: true),

                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 90),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = favorites[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: FavoriteItemCard(
                          index: index,
                          title: item['title'],
                          posterUrl: item['poster'],
                          genres: List<String>.from(item['genres']),
                          description: item['description'] ?? "",
                        ),
                      );
                    }, childCount: favorites.length),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
