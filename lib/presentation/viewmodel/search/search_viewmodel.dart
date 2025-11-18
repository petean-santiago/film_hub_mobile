import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class SearchState {
  final String query;
  final bool isLoading;
  final List<String> results;

  SearchState({
    this.query = "",
    this.isLoading = false,
    this.results = const [],
  });

  SearchState copyWith({
    String? query,
    bool? isLoading,
    List<String>? results,
  }) {
    return SearchState(
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
      results: results ?? this.results,
    );
  }
}

class SearchViewModel extends StateNotifier<SearchState> {
  SearchViewModel() : super(SearchState());

  void onQueryChanged(String newQuery) async {
    state = state.copyWith(query: newQuery);

    if (newQuery.isEmpty) {
      state = state.copyWith(results: [], isLoading: false);
      return;
    }

    state = state.copyWith(isLoading: true);

    await Future.delayed(const Duration(milliseconds: 400));

    state = state.copyWith(
      isLoading: false,
      results: List.generate(
        6,
        (index) => "Movie Result ${index + 1} for '$newQuery'",
      ),
    );
  }
}

final searchViewModelProvider =
    StateNotifierProvider<SearchViewModel, SearchState>(
      (ref) => SearchViewModel(),
    );

final searchTextControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});
