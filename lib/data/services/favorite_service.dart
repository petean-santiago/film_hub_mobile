import 'package:film_hub/config/env/env.dart';
import '../models/movie/movie_list_response.dart';
import 'api_client.dart';

class FavoriteService {
  final ApiClient apiClient;

  FavoriteService(this.apiClient);

  Future<MovieListResponse> getFavoriteMovies({int page = 1}) async {
    final response = await apiClient.get(
      '/account/${Env.accountID}/favorite/movies',
      query: {'page': page},
    );
    return MovieListResponse.fromJson(response.data);
  }

  Future<bool> toggleFavorite({
    required int movieId,
    required bool isFavorite,
  }) async {
    final response = await apiClient.post(
      '/account/${Env.accountID}/favorite',
      data: {
        "media_type": "movie",
        "media_id": movieId,
        "favorite": isFavorite,
      },
    );
    final statusCode = response.data["status_code"];
    return statusCode == 1 || statusCode == 12 || statusCode == 13;
  }

  Future<bool> isMovieFavorite(int movieId) async {
    final response = await apiClient.get('/movie/$movieId/account_states');
    return response.data['favorite'] ?? false;
  }
}
