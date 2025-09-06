import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/photo_model.dart';


class SearchState {
  final List<PhotoModel> photos;
  final bool isLoading;
  
  final String? error;

  SearchState({
    required this.photos,
    required this.isLoading,
    this.error,
  });

  factory SearchState.initial() {
    return SearchState(photos: [], isLoading: false, error: null);
  }
}

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(SearchState.initial());

  Future<void> searchPhotos(String query) async {
    state = SearchState(photos: [], isLoading: true);

    try {
      final response = await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=50"),
        headers: {
          "Authorization": "dVNxu7b2RLHFht6CeVUDLV61kCui9mmteMQLcra2GfrkhUVxOwKYYLNC"
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final photos = (data["photos"] as List)
            .map((e) => PhotoModel.fromMap(e))
            .toList();

        state = SearchState(photos: photos, isLoading: false);
      } else {
        state = SearchState(
          photos: [],
          isLoading: false,
          error: "Error: ${response.statusCode}",
        );
      }
    } catch (e) {
      state = SearchState(
        photos: [],
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

/// Provider
final searchProvider =
    StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  return SearchNotifier();
});
