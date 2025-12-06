import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../data/services/api_client.dart';
import '../../../data/services/movie_service.dart';
import '../viewmodel/search/search_viewmodel.dart';

final movieServiceProvider = Provider((ref) => MovieService(ApiClient()));

final searchViewModelProvider =
    StateNotifierProvider<SearchViewModel, SearchState>(
      (ref) => SearchViewModel(ref.read(movieServiceProvider)),
    );

final searchTextControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});
