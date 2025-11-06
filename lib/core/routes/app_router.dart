import 'package:film_hub/presentation/view/home/home_view.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/view/favorites/favorites_view.dart';
import '../../presentation/view/profile/profile_view.dart';
import '../../presentation/view/search/search_view.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', name: 'home', builder: (_, __) => const HomeView()),
    GoRoute(path: '/search', name: 'search', builder: (_, __) => const SearchView()),
    GoRoute(path: '/favorites', name: 'favorites', builder: (_, __) => const FavoritesView()),
    GoRoute(path: '/profile', name: 'profile', builder: (_, __) => const ProfileView()),
  ],
);
