class MovieVideoResult {
  final String iso639_1;
  final String iso3166_1;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final DateTime publishedAt;
  final String id;

  MovieVideoResult({
    required this.iso639_1,
    required this.iso3166_1,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  factory MovieVideoResult.fromJson(Map<String, dynamic> json) {
    return MovieVideoResult(
      iso639_1: json['iso_639_1'] ?? '',
      iso3166_1: json['iso_3166_1'] ?? '',
      name: json['name'] ?? '',
      key: json['key'] ?? '',
      site: json['site'] ?? '',
      size: json['size'] ?? 0,
      type: json['type'] ?? '',
      official: json['official'] ?? false,
      publishedAt:
          DateTime.tryParse(json['published_at'] ?? '') ?? DateTime.now(),
      id: json['id'] ?? '',
    );
  }
}

class MovieVideoResponse {
  final int id;
  final List<MovieVideoResult> results;

  MovieVideoResponse({required this.id, required this.results});

  factory MovieVideoResponse.fromJson(Map<String, dynamic> json) {
    return MovieVideoResponse(
      id: json['id'] ?? 0,
      results: json['results'] != null
          ? List<MovieVideoResult>.from(
              (json['results'] as List).map(
                (x) => MovieVideoResult.fromJson(x),
              ),
            )
          : [],
    );
  }
}
