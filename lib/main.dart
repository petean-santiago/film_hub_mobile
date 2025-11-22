import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'config/theme/app_theme.dart';
import 'core/routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/env/.env");
  runApp(const ProviderScope(child: FilmHubApp()));
}

class FilmHubApp extends StatelessWidget {
  const FilmHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FilmHub',
      routerConfig: appRouter,
      theme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
    );
  }
}
