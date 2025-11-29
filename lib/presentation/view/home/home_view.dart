import 'package:film_hub/presentation/widgets/custom_silver_app_bar.dart';
import 'package:flutter/material.dart';
import '../../../data/services/api_client.dart';
import '../../../data/services/movie_service.dart';
import '../../widgets/movie_carousel.dart';
import '../../widgets/movie_category_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<String> filters = ["Trending", "Popular", "Top Rated", "Upcoming"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: CustomScrollView(
          slivers: [
            CustomSilverAppBar(filters: filters, showFilters: true),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  MovieCarousel(),
                  Transform.translate(
                    offset: const Offset(0, -120),
                    child: Column(
                      spacing: 15,
                      children: [
                        MovieCategoryList(
                          categoryTitle: "Trending Now",
                          imageUrls: [
                            'https://m.media-amazon.com/images/I/81Bl5RlsLFL._AC_UF894,1000_QL80_.jpg',
                            'https://m.media-amazon.com/images/I/81Bl5RlsLFL._AC_UF894,1000_QL80_.jpg',
                            'https://m.media-amazon.com/images/I/81Bl5RlsLFL._AC_UF894,1000_QL80_.jpg',
                            'https://m.media-amazon.com/images/I/81Bl5RlsLFL._AC_UF894,1000_QL80_.jpg',
                          ],
                        ),
                        MovieCategoryList(
                          categoryTitle: "Top Rated",
                          imageUrls: [
                            'https://m.media-amazon.com/images/I/81Bl5RlsLFL._AC_UF894,1000_QL80_.jpg',
                            'https://m.media-amazon.com/images/I/81Bl5RlsLFL._AC_UF894,1000_QL80_.jpg',
                            'https://m.media-amazon.com/images/I/81Bl5RlsLFL._AC_UF894,1000_QL80_.jpg',
                            'https://m.media-amazon.com/images/I/81Bl5RlsLFL._AC_UF894,1000_QL80_.jpg',
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
