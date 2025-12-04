import 'package:flutter/material.dart';
import '../../config/env/env.dart';
import '../../data/models/movie/movie_list_response.dart';
import '../../data/services/api_client.dart';
import '../../data/services/movie_service.dart';
import '../../core/constants/movie_category_mapping.dart';
import '../view/shared/movie_detail_view.dart';

class MovieCategoryList extends StatefulWidget {
  final String categoryTitle;

  const MovieCategoryList({super.key, required this.categoryTitle});

  @override
  State<MovieCategoryList> createState() => _MovieCategoryListState();
}

class _MovieCategoryListState extends State<MovieCategoryList> {
  final movieService = MovieService(ApiClient());
  late Future<MovieListResponse> _moviesFuture;

  @override
  void initState() {
    super.initState();
    if (widget.categoryTitle == 'popular') {
      _moviesFuture = movieService.getPopularMovies();
    }
    if (widget.categoryTitle == 'top_rated') {
      _moviesFuture = movieService.getTopRatedMovies();
    }
    if (widget.categoryTitle == 'upcoming') {
      _moviesFuture = movieService.getUpcomingMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            MovieCategoryMapping.name(widget.categoryTitle),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 0.5,
            ),
          ),
        ),

        FutureBuilder(
          future: _moviesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(); //TODO: Create shimmer
            }
            if (snapshot.hasData) {
              final MovieListResponse movies =
                  snapshot.data as MovieListResponse;

              return SizedBox(
                height: screenWidth * 0.5,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: movies.results.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final safeIndex = index.clamp(0, movies.results.length - 1);
                    final backgroundImage =
                        '${Env.imageBaseUrl}/w500${movies.results[safeIndex].posterPath!}';
                    final id = movies.results[safeIndex].id;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MovieDetailView(
                              imageUrl: backgroundImage,
                              index: index,
                              id: id,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'image-poster-$index',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AspectRatio(
                            aspectRatio: 2 / 3,
                            child: Image.network(
                              backgroundImage,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) =>
                                  progress == null
                                  ? child
                                  : Container(
                                      color: Colors.grey.shade900,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.grey.shade900,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.broken_image_rounded,
                                  color: Colors.white38,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }
}
