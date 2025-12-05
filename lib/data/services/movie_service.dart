import 'package:film_hub/data/models/movie/movie_model.dart';

import '../models/movie/movie_detail_model.dart';
import '../models/movie/movie_list_response.dart';
import '../models/movie/movie_video_model.dart';
import 'api_client.dart';

class MovieService {
  final ApiClient apiClient;

  MovieService(this.apiClient);

  Future<MovieDetailModel> getMovie(int id) async {
    final response = await apiClient.get('/movie/$id');
    return MovieDetailModel.fromJson(response.data);
  }

  Future<MovieVideoResponse> getMovieVideos(int id) async {
    final response = await apiClient.get('/movie/$id/videos');
    return MovieVideoResponse.fromJson(response.data);
  }

  Future<MovieListResponse> getPopularMovies({int page = 1}) async {
    final response = await apiClient.get(
      '/movie/popular',
      query: {'page': page},
    );
    return MovieListResponse.fromJson(response.data);
  }

  Future<MovieListResponse> getNowPlayingMovies({int page = 1}) async {
    final response = await apiClient.get(
      '/movie/now_playing',
      query: {'page': page},
    );
    return MovieListResponse.fromJson(response.data);
  }

  Future<MovieListResponse> getTopRatedMovies({int page = 1}) async {
    final response = await apiClient.get(
      '/movie/top_rated',
      query: {'page': page},
    );
    return MovieListResponse.fromJson(response.data);
  }

  Future<MovieListResponse> getUpcomingMovies({int page = 1}) async {
    final response = await apiClient.get(
      '/movie/upcoming',
      query: {'page': page},
    );
    return MovieListResponse.fromJson(response.data);
  }

  Future<MovieListResponse> searchMovies({
    required String query,
    int page = 1,
    bool includeAdult = false,
  }) async {
    final response = await apiClient.get(
      '/search/movie',
      query: {'query': query, 'page': page, 'include_adult': includeAdult},
    );
    return MovieListResponse.fromJson(response.data);
  }
}
