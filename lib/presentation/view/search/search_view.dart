import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/providers/search_providers.dart';
import '../../../application/viewmodel/search/search_viewmodel.dart';
import '../../widgets/search_result_item.dart';
import '../../widgets/search_trending_list.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchViewModelProvider);
    final controller = ref.watch(searchTextControllerProvider);
    ref.listen<SearchState>(searchViewModelProvider, (prev, next) {
      if (next.query != controller.text) {
        controller.text = next.query;
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: next.query.length),
        );
      }
    });
    final viewModel = ref.read(searchViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Theme(
          data: Theme.of(context).copyWith(
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Colors.white,
              selectionColor: Colors.white10,
              selectionHandleColor: Colors.white,
            ),
          ),
          child: TextField(
            controller: controller,
            onChanged: viewModel.onQueryChanged,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Search movies...",
              hintStyle: TextStyle(color: Colors.white54),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.1),
              prefixIcon: const Icon(Icons.search, color: Colors.white70),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          child: state.query.isEmpty
              ? SearchTrendingList()
              : state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 75.0),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, index) {
                      final movie = state.results[index];
                      return AnimatedSearchResultItem(
                        index: index,
                        child: SearchResultItem(movie: movie, index: index),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemCount: state.results.length,
                  ),
                ),
        ),
      ),
    );
  }
}

class AnimatedSearchResultItem extends StatefulWidget {
  final int index;
  final Widget child;

  const AnimatedSearchResultItem({
    super.key,
    required this.index,
    required this.child,
  });

  @override
  State<AnimatedSearchResultItem> createState() =>
      _AnimatedSearchResultItemState();
}

class _AnimatedSearchResultItemState extends State<AnimatedSearchResultItem> {
  double _value = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 40 * widget.index), () {
      if (mounted) setState(() => _value = 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: _value),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: Transform.scale(scale: 0.95 + (value * 0.05), child: child),
          ),
        );
      },
      child: widget.child,
    );
  }
}
