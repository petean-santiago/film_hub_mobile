import 'package:flutter/material.dart';
import 'package:film_hub/presentation/widgets/custom_silver_app_bar.dart';

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
    },
    {
      'title': 'Spirited Away',
      'poster':
          'https://image.tmdb.org/t/p/w500/oRvMaJOmapypFUcQqpgHMZA6qL9.jpg',
      'genres': ['Fantasy', 'Animation'],
    },
  ];

  final List<String> filters = ["All", "Movies", "Series"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: CustomScrollView(
          slivers: [
            CustomSilverAppBar(filters: filters, showFilters: true),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = favorites[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Card(
                    color: Colors.grey.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Poster
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          child: Image.network(
                            item['poster'],
                            width: 100,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                Wrap(
                                  spacing: 8,
                                  children: item['genres']
                                      .map<Widget>(
                                        (g) => Chip(
                                          label: Text(g),
                                          labelStyle: const TextStyle(
                                            color: Colors.black,
                                          ),
                                          backgroundColor:
                                              Colors.blueGrey.shade100,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: favorites.length),
            ),
          ],
        ),
      ),
    );
  }
}
