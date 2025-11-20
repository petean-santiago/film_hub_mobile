import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:film_hub/presentation/widgets/app_bottom_nav_bar.dart';
import 'package:film_hub/presentation/view/home/home_view.dart';
import 'package:film_hub/presentation/view/search/search_view.dart';
import 'package:film_hub/presentation/view/favorites/favorites_view.dart';
import 'package:film_hub/presentation/view/profile/profile_view.dart';

int lastIndex = 0;

int getIndexFromPath(String location) {
  return switch (location) {
    '/' => 0,
    '/search' => 1,
    '/favorites' => 2,
    _ => 3,
  };
}

CustomTransitionPage buildPageWithSlide({
  required Widget child,
  required int fromIndex,
  required int toIndex,
}) {
  final isForward = toIndex > fromIndex;

  return CustomTransitionPage(
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (_, animation, __, child) {
      final offset = isForward ? const Offset(1, 0) : const Offset(-1, 0);

      return SlideTransition(
        position: animation.drive(
          Tween(
            begin: offset,
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutCubic)),
        ),
        child: child,
      );
    },
  );
}

final appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        final index = getIndexFromPath(state.uri.toString());

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
        GoRoute(
          path: '/',
          pageBuilder: (context, state) {
            final currentIndex = 0;
            final page = buildPageWithSlide(
              child: const HomeView(),
              fromIndex: lastIndex,
              toIndex: currentIndex,
            );
            lastIndex = currentIndex;
            return page;
          },
        ),
        GoRoute(
          path: '/search',
          pageBuilder: (context, state) {
            final currentIndex = 1;
            final page = buildPageWithSlide(
              child: const SearchView(),
              fromIndex: lastIndex,
              toIndex: currentIndex,
            );
            lastIndex = currentIndex;
            return page;
          },
        ),
        GoRoute(
          path: '/favorites',
          pageBuilder: (context, state) {
            final currentIndex = 2;
            final page = buildPageWithSlide(
              child: const FavoritesView(),
              fromIndex: lastIndex,
              toIndex: currentIndex,
            );
            lastIndex = currentIndex;
            return page;
          },
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) {
            final currentIndex = 3;
            final page = buildPageWithSlide(
              child: const ProfileView(),
              fromIndex: lastIndex,
              toIndex: currentIndex,
            );
            lastIndex = currentIndex;
            return page;
          },
        ),
      ],
    ),
  ],
);
