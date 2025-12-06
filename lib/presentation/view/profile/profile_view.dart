import 'dart:ui';
import 'package:film_hub/presentation/view/profile/widgets/build_background.dart';
import 'package:film_hub/presentation/view/profile/widgets/build_stats.dart';
import 'package:film_hub/presentation/view/profile/widgets/profile_image.dart';
import 'package:film_hub/presentation/view/profile/widgets/profile_view_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../application/providers/user_providers.dart';
import './widgets/glass_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);
    final favoritesAsync = ref.watch(favoritesProvider);
    final watchlistAsync = ref.watch(watchlistProvider);
    final ratedAsync = ref.watch(ratedMoviesProvider);

    return userAsync.when(
      loading: () => ProfileViewSkeleton(),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (user) {
        final avatarHash = user.avatar.gravatar.hash;
        final avatarUrl =
            "https://www.gravatar.com/avatar/$avatarHash?s=200&d=identicon";

        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              buildBackground(),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 50,
                ),
                child: Column(
                  children: [
                    profileImage(avatarUrl),
                    const SizedBox(height: 20),

                    // NAME + USERNAME
                    Text(
                      user.username,
                      style: const TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      user.iso31661,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // USER STATS ----------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildStat(
                          "Favorites",
                          favoritesAsync.value?.results.length.toString() ??
                              "-",
                        ),
                        buildStat(
                          "Watchlist",
                          watchlistAsync.value?.results.length.toString() ??
                              "-",
                        ),
                        buildStat(
                          "Ratings",
                          ratedAsync.value?.results.length.toString() ?? "-",
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // ACTIONS -------------------------------
                    glassCard(
                      width: MediaQuery.of(context).size.width,
                      icon: FontAwesomeIcons.solidHeart,
                      title: "Your Favorites",
                      onTap: () {
                        context.go('/favorites');
                      },
                    ),
                    const SizedBox(height: 12),
                    glassCard(
                      width: MediaQuery.of(context).size.width,
                      icon: FontAwesomeIcons.bookmark,
                      title: "Watchlist",
                      onTap: () {},
                      disabled: true,
                    ),
                    const SizedBox(height: 12),
                    glassCard(
                      width: MediaQuery.of(context).size.width,
                      icon: FontAwesomeIcons.solidStar,
                      title: "Your Ratings",
                      onTap: () {},
                      disabled: true,
                    ),

                    const SizedBox(height: 20),

                    // LOGOUT ---------------------------------
                    IgnorePointer(
                      ignoring: true,
                      child: Opacity(
                        opacity: 0.4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.redAccent.withValues(alpha: 0.10),
                            border: Border.all(
                              color: Colors.redAccent.withValues(alpha: 0.25),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.logout, color: Colors.redAccent),
                              SizedBox(width: 10),
                              Text(
                                "Logout",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
