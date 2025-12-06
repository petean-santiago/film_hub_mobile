import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../data/models/movie/movie_model.dart';
import '../../../data/services/api_client.dart';
import '../../../data/services/movie_service.dart';

class SearchState {
  final String query;
  final bool isLoading;
  final List<MovieModel> results;

  SearchState({
    this.query = "",
    this.isLoading = false,
    this.results = const [],
  });

  SearchState copyWith({
    String? query,
    bool? isLoading,
    List<MovieModel>? results,
  }) {
    return SearchState(
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
      results: results ?? this.results,
    );
  }
}

class SearchViewModel extends StateNotifier<SearchState> {
  final MovieService movieService;
  Timer? _debounce;

  SearchViewModel(this.movieService) : super(SearchState());

  void onQueryChanged(String newQuery) {
    state = state.copyWith(query: newQuery);

    _debounce?.cancel();

    if (newQuery.isEmpty) {
      state = state.copyWith(results: [], isLoading: false);
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 400), () async {
      state = state.copyWith(isLoading: true);

      try {
        final response = await movieService.searchMovies(query: newQuery);
        state = state.copyWith(isLoading: false, results: response.results);
      } catch (e) {
        state = state.copyWith(isLoading: false, results: []);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
