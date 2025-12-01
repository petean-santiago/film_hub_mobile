import 'movie_company_model.dart';
import 'movie_genre_model.dart';
import 'movie_production_country_model.dart';
import 'movie_spoken_language_model.dart';

class MovieDetailModel {
  final bool adult;
  final String? backdropPath;
  final int budget;
  final List<Genre> genres;
  final String? homepage;
  final int id;
  final String? imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String? tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDetailModel({
    required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'],
      budget: json['budget'] ?? 0,
      genres:
          (json['genres'] as List<dynamic>?)
              ?.map((e) => Genre.fromJson(e))
              .toList() ??
          [],
      homepage: json['homepage'],
      id: json['id'] ?? 0,
      imdbId: json['imdb_id'],
      originalLanguage: json['original_language'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      posterPath: json['poster_path'],
      productionCompanies:
          (json['production_companies'] as List<dynamic>?)
              ?.map((e) => ProductionCompany.fromJson(e))
              .toList() ??
          [],
      productionCountries:
          (json['production_countries'] as List<dynamic>?)
              ?.map((e) => ProductionCountry.fromJson(e))
              .toList() ??
          [],
      releaseDate: json['release_date'] ?? '',
      revenue: json['revenue'] ?? 0,
      runtime: json['runtime'] ?? 0,
      spokenLanguages:
          (json['spoken_languages'] as List<dynamic>?)
              ?.map((e) => SpokenLanguage.fromJson(e))
              .toList() ??
          [],
      status: json['status'] ?? '',
      tagline: json['tagline'],
      title: json['title'] ?? '',
      video: json['video'] ?? false,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
    );
  }
}
