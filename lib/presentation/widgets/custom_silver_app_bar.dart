import 'dart:ui';
import 'package:flutter/material.dart';

import '../../core/constants/movie_category_mapping.dart';

class CustomSilverAppBar extends StatefulWidget {
  final List<String> filters;
  final bool showFilters;

  const CustomSilverAppBar({
    super.key,
    required this.filters,
    required this.showFilters,
  });

  @override
  State<CustomSilverAppBar> createState() => _CustomSilverAppBarState();
}

class _CustomSilverAppBarState extends State<CustomSilverAppBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final showFilters = widget.showFilters;
    final filters = widget.filters;

    return SliverAppBar(
      floating: true,
      snap: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.75),
              border: Border(
                bottom: BorderSide(
                  color: Colors.black.withValues(alpha: 0.55),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ),

      title: const Text(
        "FilmHub",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),

      bottom: showFilters
          ? PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: 50,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final isSelected = selectedIndex == index;

                      return GestureDetector(
                        onTap: () => setState(() => selectedIndex = index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: isSelected
                                ? Colors.white.withValues(alpha: 0.9)
                                : Colors.white.withValues(alpha: 0.10),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.15),
                              width: 1.3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minWidth: 30),
                            child: Center(
                              child: Text(
                                MovieCategoryMapping.name(filters[index]),
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemCount: filters.length,
                  ),
                ),
              ),
            )
          : const PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: SizedBox(),
            ),
    );
  }
}
