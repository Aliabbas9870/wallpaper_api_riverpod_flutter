import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper/core/app_colors.dart';
import 'package:wallpaper/provider/search_photo_provider.dart';
import 'package:wallpaper/widgets/widget.dart';



final isSearchingProvider = StateProvider<bool>((ref) => false);

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchProvider);
    final searchNotifier = ref.read(searchProvider.notifier);
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
          Center(
            child: Text(
              'Search',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 10),
         

         Container(
  margin: const EdgeInsets.symmetric(horizontal: 16),
  padding: const EdgeInsets.symmetric(horizontal: 14),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: AppColors.lightGrey,
  ),
  child: Consumer(
    builder: (context, ref, _) {
      final isSearching = ref.watch(isSearchingProvider);
      final searchNotifier = ref.read(searchProvider.notifier);

      return TextField(
        controller: searchController,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              isSearching ? Icons.close : Icons.search_outlined,
            ),
            onPressed: () {
              if (isSearching) {
                // Close → clear text & reset results
                searchController.clear();
                ref.read(isSearchingProvider.notifier).state = false;
                searchNotifier.state = SearchState.initial();
              } else {
                // Search → fetch photos
                if (searchController.text.isNotEmpty) {
                  searchNotifier.searchPhotos(searchController.text);
                  ref.read(isSearchingProvider.notifier).state = true;
                }
              }
            },
          ),
          border: InputBorder.none,
        ),
      );
    },
  ),
),

          const SizedBox(height: 16),
          Expanded(
            child: searchState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : searchState.error != null
                    ? Center(child: Text(searchState.error!))
                    : searchState.photos.isNotEmpty
                        ? wallpaper(searchState.photos, context)
                        : const Center(child: Text("No results found")),
          ),
        ],
      ),
    );
  }
}
