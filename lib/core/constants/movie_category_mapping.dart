class MovieCategoryMapping {
  static const Map<String, String> categories = {
    "now_playing": 'Trending',
    "popular": 'Popular',
    "top_rated": 'Top rated',
    "upcoming": 'Upcoming',
  };

  static String name(String key) => categories[key] ?? "Unknown";
}
