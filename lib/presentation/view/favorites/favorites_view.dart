import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:film_hub/presentation/widgets/custom_silver_app_bar.dart';
import '../../../config/env/env.dart';
import '../../../data/models/movie/movie_list_response.dart';
import '../../../data/services/api_client.dart';
import '../../../data/services/user_service.dart';
import '../../widgets/favorite_item_card.dart';
import '../../widgets/skeletons/favorite_view_skeleton.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final favoriteService = UserService(ApiClient());
  late Future<MovieListResponse> _favoritesFuture;
  int selectedGenreId = 0;

  @override
  void initState() {
    super.initState();
    _favoritesFuture = favoriteService.getFavoriteMovies();
  }

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
                "https://64.media.tumblr.com/17c959d20b8657d699efeea44760ab02/tumblr_petzq2fidq1uzwgsuo1_400.gif",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(color: Colors.black.withValues(alpha: 0.45)),
            ),
          ),

          FutureBuilder<MovieListResponse>(
            future: _favoritesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const FavoritesViewSkeleton();
              }

              if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
                return const Center(
                  child: Text(
                    "You don't have any favorites yet",
                    style: TextStyle(color: Colors.white70),
                  ),
                );
              }

              final allFavorites = snapshot.data!.results;

              final favorites = selectedGenreId == 0
                  ? allFavorites
                  : allFavorites
                        .where(
                          (movie) => movie.genreIds.contains(selectedGenreId),
                        )
                        .toList();

              return ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: CustomScrollView(
                  slivers: [
                    CustomSilverAppBar(
                      showFilters: true,
                      onCategorySelected: (genreId) {
                        setState(() {
                          selectedGenreId = int.tryParse(genreId)!;
                        });
                      },
                    ),
                    favorites.isEmpty
                        ? SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 120),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.local_movies_outlined,
                                    size: 64,
                                    color: Colors.white38,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "No movies found in this category",
                                    //TODO: improve placeholder
                                    style: TextStyle(
                                      color: Colors.white.withValues(
                                        alpha: 0.75,
                                      ),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SliverPadding(
                            padding: const EdgeInsets.only(bottom: 90),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate((
                                context,
                                index,
                              ) {
                                final movie = favorites[index];

                                return AnimatedFavoriteItem(
                                  index: index,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    child: FavoriteItemCard(
                                      id: movie.id,
                                      index: index,
                                      title: movie.title,
                                      posterUrl:
                                          '${Env.imageBaseUrl}/w500${movie.posterPath}',
                                      genres: movie.genreIds,
                                      description: movie.overview,
                                    ),
                                  ),
                                );
                              }, childCount: favorites.length),
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AnimatedFavoriteItem extends StatefulWidget {
  final int index;
  final Widget child;

  const AnimatedFavoriteItem({
    super.key,
    required this.index,
    required this.child,
  });

  @override
  State<AnimatedFavoriteItem> createState() => _AnimatedFavoriteItemState();
}

class _AnimatedFavoriteItemState extends State<AnimatedFavoriteItem> {
  double _value = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 30 * widget.index), () {
      if (mounted) setState(() => _value = 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: _value),
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: Transform.scale(scale: 0.95 + (value * 0.05), child: child),
          ),
        );
      },
      child: widget.child,
    );
  }
}
