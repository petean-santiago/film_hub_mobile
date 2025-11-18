import 'package:flutter/material.dart';

class SearchResultItem extends StatelessWidget {
  final String movie;

  const SearchResultItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 90,
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white.withValues(alpha: 0.12),
          ),
        ),
        const SizedBox(width: 14),
        Text(movie, style: const TextStyle(color: Colors.white, fontSize: 18)),
      ],
    );
  }
}
