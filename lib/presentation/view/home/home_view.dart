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
  final List<String> filtersKeys = [
    "trending",
    "popular",
    "top_rated",
    "upcoming",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: CustomScrollView(
          slivers: [
            CustomSilverAppBar(filters: filtersKeys, showFilters: true),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  MovieCarousel(),
                  Transform.translate(
                    offset: const Offset(0, -50),
                    child: Column(
                      spacing: 15,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filtersKeys.length,
                          itemBuilder: (context, index) {
                            return filtersKeys[index] != 'trending'
                                ? MovieCategoryList(
                                    categoryTitle: filtersKeys[index],
                                    imageUrls: [
                                      'https://m.media-amazon.com/images/I/81Bl5RlsLFL._AC_UF894,1000_QL80_.jpg',
                                      'https://m.media-amazon.com/images/I/81Bl5RlsLFL._AC_UF894,1000_QL80_.jpg',
                                      'https://m.media-amazon.com/images/I/81Bl5RlsLFL._AC_UF894,1000_QL80_.jpg',
                                      'https://m.media-amazon.com/images/I/81Bl5RlsLFL._AC_UF894,1000_QL80_.jpg',
                                    ],
                                  )
                                : SizedBox();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
