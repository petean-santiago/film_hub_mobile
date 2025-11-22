class PaginatedResponse<T> {
  final int page;
  final List<T> results;
  final int totalPages;
  final int totalResults;

  PaginatedResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedResponse(
      page: json['page'],
      results: List<T>.from(json['results'].map((item) => fromJsonT(item))),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}
