import 'package:flutter/material.dart';
import '../../config/env/env.dart';
import '../../core/constants/genre_mapping.dart';
import '../../data/models/movie/movie_model.dart';
import 'build_tag.dart';
import '../view/shared/movie_detail_view.dart';

class SearchResultItem extends StatelessWidget {
  final MovieModel movie;
  final int index;

  const SearchResultItem({super.key, required this.movie, required this.index});

  @override
  Widget build(BuildContext context) {
    String backgroundImage = '${Env.imageBaseUrl}/w500${movie.posterPath}';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailView(
              imageUrl: backgroundImage,
              index: index,
              id: movie.id,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'image-poster-$index',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  backgroundImage,
                  width: 90,
                  height: 130,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 90,
                      height: 130,
                      color: Colors.white.withValues(alpha: 0.12),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 90,
                    height: 130,
                    color: Colors.white.withValues(alpha: 0.12),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.broken_image_rounded,
                      color: Colors.white38,
                      size: 36,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                  const SizedBox(height: 6),

                  Wrap(
                    spacing: 10,
                    runSpacing: 4,
                    children: [
                      Text(
                        movie.releaseDate.split('-').first,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            movie.voteAverage.toStringAsFixed(1),
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 5,
                    runSpacing: 0,
                    children: [
                      if (movie.genreIds.isNotEmpty)
                        buildTag(GenreMapping.name(movie.genreIds[0])),

                      if (movie.genreIds.length > 1)
                        buildTag(GenreMapping.name(movie.genreIds[1])),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
