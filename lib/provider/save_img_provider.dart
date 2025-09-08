import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

final saveImageProvider =
    StateNotifierProvider<SaveImageNotifier, AsyncValue<String>>(
  (ref) => SaveImageNotifier(),
);

class SaveImageNotifier extends StateNotifier<AsyncValue<String>> {
  SaveImageNotifier() : super(const AsyncValue.data(""));

  Future<void> save(String imgPath) async {
    state = const AsyncValue.loading();
    try {
      var response = await Dio().get(
        imgPath,
        options: Options(responseType: ResponseType.bytes),
      );

      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100,
        name: "wallpaper_${DateTime.now().millisecondsSinceEpoch}",
      );

      state = AsyncValue.data("Image saved: $result");
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
