import 'package:flutter/material.dart';

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
    var filters = widget.filters;

    return SliverAppBar(
      backgroundColor: Colors.black,
      floating: true,
      snap: true,
      elevation: 0,
      title: const Text(
        "FilmHub",
        style: TextStyle(fontWeight: FontWeight.bold),
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
                        onTap: () {
                          setState(() => selectedIndex = index);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.white12,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minWidth: 30),
                            child: Center(
                              child: Text(
                                filters[index],
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
          : PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: SizedBox(),
            ),
    );
  }
}
