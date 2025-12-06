import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/movie/movie_list_response.dart';
import '../../data/services/api_client.dart';
import '../../data/services/movie_service.dart';

final movieCategoryProvider = FutureProvider.family<MovieListResponse, String>((
  ref,
  category,
) async {
  final service = MovieService(ApiClient());

  switch (category) {
    case 'popular':
      return service.getPopularMovies();
    case 'top_rated':
      return service.getTopRatedMovies();
    case 'upcoming':
      return service.getUpcomingMovies();
    default:
      throw Exception('Invalid category: $category');
  }
});
