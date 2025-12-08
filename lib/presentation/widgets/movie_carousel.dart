import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:film_hub/config/env/env.dart';
import 'package:film_hub/core/constants/genre_mapping.dart';
import 'package:film_hub/presentation/widgets/skeletons/movie_carousel_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/movie/movie_list_response.dart';
import '../../application/providers/movie_carousel_provider.dart';
import 'build_tag.dart';

class MovieCarousel extends ConsumerStatefulWidget {
  const MovieCarousel({super.key});

  @override
  ConsumerState<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends ConsumerState<MovieCarousel>
    with AutomaticKeepAliveClientMixin {
  int _current = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final carouselHeight = screenHeight * 0.55;
    final viewportFraction = screenWidth < 400 ? 0.7 : 0.55;

    final movieAsync = ref.watch(movieCarouselProvider);

    return movieAsync.when(
      loading: () => const MovieCarouselSkeleton(),

      error: (e, _) => const SizedBox(),

      data: (MovieListResponse movies) {
        final safeIndex = _current.clamp(0, movies.results.length - 1);
        final movie = movies.results[safeIndex];

        final backgroundImage = '${Env.imageBaseUrl}/w500${movie.posterPath!}';

        final title = movie.title;
        final year = movie.releaseDate.substring(0, 4);
        final voteAverage = movie.voteAverage;
        final id = movie.id;
        final genresIds = movie.genreIds;

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
                  itemCount: movies.results.length,
                  itemBuilder: (context, index, realIndex) {
                    final isActive = index == safeIndex;

                    final poster =
                        '${Env.imageBaseUrl}/w500${movies.results[index].posterPath!}';

                    return Column(
                      children: [
                        AnimatedScale(
                          scale: isActive ? 1.0 : 0.85,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOutBack,
                          child: AnimatedOpacity(
                            opacity: isActive ? 1.0 : 0.4,
                            duration: const Duration(milliseconds: 300),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 12,
                              ),
                              child: AspectRatio(
                                aspectRatio: 2 / 3,
                                child: GestureDetector(
                                  onTap: () {
                                    context.push(
                                      '/movie',
                                      extra: {
                                        'imageUrl': poster,
                                        'index': index,
                                        'id': movies.results[index].id,
                                      },
                                    );
                                  },
                                  child: Hero(
                                    tag: 'image-poster-$index',
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        poster,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        loadingBuilder:
                                            (context, child, loading) {
                                              if (loading == null) return child;

                                              return AnimatedOpacity(
                                                opacity: 0.3,
                                                duration: const Duration(
                                                  milliseconds: 300,
                                                ),
                                                child: child,
                                              );
                                            },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 550),
                          switchInCurve: Curves.easeOutExpo,
                          switchOutCurve: Curves.easeInExpo,
                          transitionBuilder: (child, animation) {
                            final fade = CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOut,
                            );

                            final slide =
                                Tween<Offset>(
                                  begin: const Offset(0, 0.25),
                                  end: Offset.zero,
                                ).animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeOutQuart,
                                  ),
                                );

                            return FadeTransition(
                              opacity: fade,
                              child: SlideTransition(
                                position: slide,
                                child: child,
                              ),
                            );
                          },
                          child: isActive
                              ? Padding(
                                  key: ValueKey(index),
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Column(
                                    children: [
                                      Text(
                                        year,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        title,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Wrap(
                                        alignment: WrapAlignment.center,
                                        spacing: 5,
                                        runSpacing: 5,
                                        children: [
                                          if (genresIds.isNotEmpty)
                                            buildTag(
                                              GenreMapping.name(
                                                genresIds.first,
                                              ),
                                            ),
                                          if (genresIds.length > 1)
                                            buildTag(
                                              GenreMapping.name(genresIds[1]),
                                            ),
                                          _buildRating(voteAverage),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
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
      },
    );
  }

  Widget _buildRating(double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(FontAwesomeIcons.solidStar, size: 14, color: Colors.amber),
          const SizedBox(width: 5),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              color: Colors.amber,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
