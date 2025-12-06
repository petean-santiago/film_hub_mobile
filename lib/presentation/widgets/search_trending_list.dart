import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/search_providers.dart';

class SearchTrendingList extends ConsumerWidget {
  const SearchTrendingList({super.key});

  final trending = const [
    "Matrix",
    "Breaking Bad",
    "Dune",
    "Batman",
    "Spiderman",
    "Interstellar",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(searchViewModelProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Trending Searches",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: trending.map((title) {
            return GestureDetector(
              onTap: () {
                viewModel.onQueryChanged(title);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(title, style: const TextStyle(color: Colors.white)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
