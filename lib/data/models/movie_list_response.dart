import 'package:film_hub/data/models/paginated_response.dart';
import 'dates_model.dart';
import 'movie_model.dart';

class MovieListResponse extends PaginatedResponse<MovieModel> {
  final DatesModel? dates;

  MovieListResponse({
    required super.page,
    required super.results,
    required super.totalPages,
    required super.totalResults,
    this.dates,
  });

  factory MovieListResponse.fromJson(Map<String, dynamic> json) {
    return MovieListResponse(
      dates: json['dates'] != null ? DatesModel.fromJson(json['dates']) : null,
      page: json['page'],
      results: (json['results'] as List)
          .map((m) => MovieModel.fromJson(m))
          .toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}
