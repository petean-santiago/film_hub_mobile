import 'package:flutter_riverpod/flutter_riverpod.dart';

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
