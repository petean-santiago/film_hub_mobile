import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/user/user_model.dart';
import '../../../data/services/api_client.dart';
import '../../../data/services/user_service.dart';
import '../../data/models/movie/movie_list_response.dart';

final _userServiceProvider = Provider((ref) => UserService(ApiClient()));

/// USER DETAILS
final userProvider = FutureProvider.autoDispose<UserModel>((ref) async {
  final service = ref.read(_userServiceProvider);
  return service.getUserDetails();
});

/// FAVORITES
final favoritesProvider = FutureProvider.autoDispose<MovieListResponse>((
  ref,
) async {
  final service = ref.read(_userServiceProvider);
  return service.getFavoriteMovies();
});

/// WATCHLIST
final watchlistProvider = FutureProvider.autoDispose<MovieListResponse>((
  ref,
) async {
  final service = ref.read(_userServiceProvider);
  return service.getRatedMovies();
});

///  USER RATINGS
final ratedMoviesProvider = FutureProvider.autoDispose<MovieListResponse>((
  ref,
) async {
  final service = ref.read(_userServiceProvider);
  return service.getRatedMovies();
});
