import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/services/api_client.dart';
import '../../../data/services/movie_service.dart';

class FavoriteMovieNotifier extends StateNotifier<bool> {
  FavoriteMovieNotifier() : super(false);

  void toggleFavorite() {
    state = !state;
  }
}

final favoriteMovieProvider =
    StateNotifierProvider<FavoriteMovieNotifier, bool>(
      (ref) => FavoriteMovieNotifier(),
    );

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
