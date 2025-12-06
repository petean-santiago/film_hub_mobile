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
                                    context.push(
                                      '/movie',
                                      extra: {
                                        'imageUrl': backgroundImage,
                                        'index': index,
                                        'id': id,
                                      },
                                    );
                                  },
                                  child: Hero(
                                    tag: 'image-poster-$index',
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        poster,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                ),

                                if (!isActive)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 250,
                                      ),
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        if (isActive)
                          Padding(
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
                                    _buildTag(GenreMapping.name(genresIds[0])),

                                    if (genresIds.length > 1)
                                      _buildTag(
                                        GenreMapping.name(genresIds[1]),
                                      ),

                                    _buildRating(voteAverage),
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
      },
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
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
