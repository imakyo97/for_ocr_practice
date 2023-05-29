import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_ocr_practice/repository/annotate_image_repository.dart';

final annotateImageDataProvider = StateProvider<Uint8List>((ref) {
  return Uint8List(0);
});

final annotateImageFutureProvider =
    FutureProvider.autoDispose<String?>((ref) async {
  final repository = ref.watch(annotateImageRepositoryProvider);
  final imageData = ref.watch(annotateImageDataProvider.notifier);
  return await repository.annotateImage(imageData.state);
});
