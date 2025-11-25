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
  final movieService = MovieService(ApiClient());

  @override
  void initState() {
    super.initState();
    loadPopular();
  }

  void loadPopular() async {
    final movies = await movieService.getPopularMovies();
    print(movies.results[0].title);
  }

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
                  MovieCarousel(
                    imageUrls: const [
                      'https://upload.wikimedia.org/wikipedia/en/thumb/d/db/The_Matrix.png/250px-The_Matrix.png',
                      'https://m.media-amazon.com/images/I/811lT7khIrL._AC_UF894,1000_QL80_.jpg',
                      'https://i.ebayimg.com/images/g/gawAAOSwfvVkgw0K/s-l1200.jpg',
                      'https://m.media-amazon.com/images/I/81pj4tb6LEL._AC_UF894,1000_QL80_.jpg',
                      'https://m.media-amazon.com/images/I/91vIHsL-zjL._AC_UF894,1000_QL80_.jpg',
                    ],
                  ),
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
