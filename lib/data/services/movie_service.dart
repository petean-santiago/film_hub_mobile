import '../models/movie_list_response.dart';
import 'api_client.dart';

class MovieService {
  final ApiClient apiClient;

  MovieService(this.apiClient);

  Future<MovieListResponse> getPopularMovies({int page = 1}) async {
    final response = await apiClient.get(
      '/movie/popular',
      query: {'page': page},
    );
    return MovieListResponse.fromJson(response.data);
  }

  Future<MovieListResponse> getNowPlayingMovies() async {
    final response = await apiClient.get('/movie/now_playing');
    return MovieListResponse.fromJson(response.data);
  }
}
