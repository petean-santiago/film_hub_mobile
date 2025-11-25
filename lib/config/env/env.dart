import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get apiKey => dotenv.env['TMDB_API_KEY'] ?? '';

  static String get baseUrl => dotenv.env['TMDB_BASE_URL'] ?? '';

  static String get imageBaseUrl => dotenv.env['IMAGE_BASE_URL'] ?? '';
}
