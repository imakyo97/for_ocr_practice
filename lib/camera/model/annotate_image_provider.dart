import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_ocr_practice/camera/model/annotate_image_repository.dart';

final imageXFileProvider = StateProvider<XFile>((ref) {
  return XFile('');
});

final annotateImageFutureProvider =
    FutureProvider.autoDispose<String?>((ref) async {
  final repository = ref.watch(annotateImageRepositoryProvider);
  final imageXFile = ref.watch(imageXFileProvider.notifier).state;
  final Uint8List bytes = await imageXFile.readAsBytes();
  return await repository.annotateImage(bytes);
});
