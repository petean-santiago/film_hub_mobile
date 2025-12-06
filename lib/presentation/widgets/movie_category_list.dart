import 'package:film_hub/presentation/widgets/skeletons/movie_category_list_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/env/env.dart';
import '../../core/constants/movie_category_mapping.dart';
import '../../application/providers/movie_category_provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MovieCategoryList extends ConsumerStatefulWidget {
  final String categoryTitle;

  const MovieCategoryList({super.key, required this.categoryTitle});

  @override
  ConsumerState<MovieCategoryList> createState() => _MovieCategoryListState();
}

class _MovieCategoryListState extends ConsumerState<MovieCategoryList>
    with AutomaticKeepAliveClientMixin {
  bool _shouldLoad = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final screenWidth = MediaQuery.of(context).size.width;

    final moviesAsync = _shouldLoad
        ? ref.watch(movieCategoryProvider(widget.categoryTitle))
        : null;

    return VisibilityDetector(
      key: Key(widget.categoryTitle),
      onVisibilityChanged: (visibilityInfo) {
        if (!_shouldLoad && visibilityInfo.visibleFraction > 0) {
          setState(() {
            _shouldLoad = true;
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

          if (!_shouldLoad)
            const MovieCategoryListSkeleton()
          else
            moviesAsync!.when(
              loading: () => const MovieCategoryListSkeleton(),
              error: (e, _) => const SizedBox(),
              data: (movies) {
                return SizedBox(
                  height: screenWidth * 0.5,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: movies.results.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final movie = movies.results[index];
                      final backgroundImage =
                          '${Env.imageBaseUrl}/w500${movie.posterPath!}';
                      final id = movie.id;

                      return GestureDetector(
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
                          tag: 'image-poster-${widget.categoryTitle}-$index',
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
              },
            ),
        ],
      ),
    );
  }
}
