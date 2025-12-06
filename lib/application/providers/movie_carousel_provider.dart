import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/movie/movie_list_response.dart';
import '../../data/services/api_client.dart';
import '../../data/services/movie_service.dart';

final movieCarouselProvider = FutureProvider<MovieListResponse>((ref) async {
  final service = MovieService(ApiClient());
  return service.getNowPlayingMovies();
});
