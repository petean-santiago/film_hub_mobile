import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../application/providers/shared/movie_detail_provider.dart';
import '../../../core/shared/global_functions.dart';
import '../../widgets/movie_video_list.dart';

class MovieDetailView extends ConsumerWidget {
  final String imageUrl;
  final int index;
  final int id;

  const MovieDetailView({
    super.key,
    required this.imageUrl,
    required this.index,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetailAsyncValue = ref.watch(movieDetailsProvider(id));
    final isFavorite = ref.watch(favoriteMovieProvider(id));
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return movieDetailAsyncValue.when(
      loading: () => Center(child: const Text('loading')),
      error: (error, stack) => Center(child: Text(error.toString())),
      data: (movie) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                  child: Container(color: Colors.black.withValues(alpha: 0.55)),
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: EdgeInsetsGeometry.only(bottom: 50),
                    child: Column(
                      children: [
                        const SizedBox(height: 65),
                        Hero(
                          tag: 'image-poster-$index',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              imageUrl,
                              height: screenHeight * 0.45,
                              width: screenWidth * 0.70,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),
                        SizedBox(
                          width: screenWidth * 0.8,
                          child: Text(
                            movie.title,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            _detailTag(movie.releaseDate.substring(0, 4)),
                            _detailTag(movie.genres[0].name),
                            movie.genres.length > 1
                                ? _detailTag(movie.genres[1].name)
                                : const SizedBox(),
                            _detailTag(formatRuntime(movie.runtime)),
                            GestureDetector(
                              onTap: () {
                                ref
                                    .read(favoriteMovieProvider(id).notifier)
                                    .toggleFavorite();
                              },
                              child: Icon(
                                FontAwesomeIcons.solidHeart,
                                size: 20,
                                color: isFavorite
                                    ? Colors.redAccent
                                    : Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.amber,
                              size: 20,
                            ),
                            SizedBox(width: 6),
                            Text(
                              movie.voteAverage.toStringAsFixed(1),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        MovieVideoListWidget(id: id),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "Overview",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          movie.overview,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _detailTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 13),
      ),
    );
  }
}
