import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:film_hub/presentation/widgets/app_bottom_nav_bar.dart';
import 'package:film_hub/presentation/view/home/home_view.dart';
import 'package:film_hub/presentation/view/search/search_view.dart';
import 'package:film_hub/presentation/view/favorites/favorites_view.dart';
import 'package:film_hub/presentation/view/profile/profile_view.dart';

final appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        final location = state.uri.toString();
        final index = switch (location) {
          '/' => 0,
          '/search' => 1,
          '/favorites' => 2,
          _ => 3,
        };

        return Scaffold(
          extendBody: true,
          body: Stack(
            children: [
              child,
              Positioned(
                left: 16,
                right: 16,
                bottom: 28,
                child: AppBottomNavBar(currentIndex: index),
              ),
            ],
          ),
        );

      },
      routes: [
        GoRoute(path: '/', builder: (_, __) => const HomeView()),
        GoRoute(path: '/search', builder: (_, __) => const SearchView()),
        GoRoute(path: '/favorites', builder: (_, __) => const FavoritesView()),
        GoRoute(path: '/profile', builder: (_, __) => const ProfileView()),
      ],
    ),
  ],
);
