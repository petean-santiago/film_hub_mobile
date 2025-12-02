class MovieCategoryMapping {
  static const Map<String, String> categories = {
    "trending": 'Trending',
    "popular": 'Popular',
    "top_rated": 'Top rated',
    "upcoming": 'Upcoming',
  };

  static String name(String key) => categories[key] ?? "Unknown";
}
