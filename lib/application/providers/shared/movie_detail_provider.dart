import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/services/api_client.dart';
import '../../../data/services/favorite_service.dart';
import '../../../data/services/movie_service.dart';

final favoriteServiceProvider = Provider<FavoriteService>((ref) {
  return FavoriteService(ApiClient());
});

class MovieNotifier extends StateNotifier<bool> {
  final FavoriteService _favoriteService;
  final int _movieId;

  MovieNotifier({
    required FavoriteService favoriteService,
    required int movieId,
  }) : _favoriteService = favoriteService,
       _movieId = movieId,
       super(false) {
    _loadInitialStatus();
  }

  Future<void> _loadInitialStatus() async {
    final isFav = await _favoriteService.isMovieFavorite(_movieId);
    if (mounted) {
      state = isFav;
    }
  }

  Future<void> toggleFavorite() async {
    final previousState = state;
    state = !state;

    try {
      final success = await _favoriteService.toggleFavorite(
        movieId: _movieId,
        isFavorite: state,
      );

      if (!success) {
        state = previousState;
      }
    } catch (e) {
      state = previousState;
    }
  }
}

final favoriteMovieProvider =
    StateNotifierProvider.family<MovieNotifier, bool, int>((ref, movieId) {
      final service = ref.watch(favoriteServiceProvider);
      return MovieNotifier(favoriteService: service, movieId: movieId);
    });

final movieDetailsProvider = FutureProvider.family.autoDispose((
  ref,
  int id,
) async {
  final movieService = MovieService(ApiClient());
  return movieService.getMovie(id);
});

final movieVideosProvider = FutureProvider.family.autoDispose((
  ref,
  int id,
) async {
  final movieService = MovieService(ApiClient());
  return movieService.getMovieVideos(id);
});
