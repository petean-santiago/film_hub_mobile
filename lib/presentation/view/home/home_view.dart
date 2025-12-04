import 'package:film_hub/presentation/widgets/custom_silver_app_bar.dart';
import 'package:flutter/material.dart';
import '../../widgets/movie_carousel.dart';
import '../../widgets/movie_category_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController scrollController = ScrollController();

  final List<String> filtersKeys = [
    "trending",
    "popular",
    "top_rated",
    "upcoming",
  ];

  final Map<String, GlobalKey> sectionKeys = {
    "trending": GlobalKey(),
    "popular": GlobalKey(),
    "top_rated": GlobalKey(),
    "upcoming": GlobalKey(),
  };

  void scrollToCategory(String category) {
    if (category == 'trending') {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      return;
    }

    final key = sectionKeys[category];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            CustomSilverAppBar(
              filters: filtersKeys,
              showFilters: true,
              onCategorySelected: scrollToCategory,
            ),

            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),

                  MovieCarousel(key: sectionKeys["trending"]),

                  Transform.translate(
                    offset: const Offset(0, -50),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filtersKeys.length,
                          itemBuilder: (context, index) {
                            final category = filtersKeys[index];
                            if (category == 'trending') {
                              return const SizedBox();
                            }
                            return Container(
                              key: sectionKeys[category],
                              child: MovieCategoryList(categoryTitle: category),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
