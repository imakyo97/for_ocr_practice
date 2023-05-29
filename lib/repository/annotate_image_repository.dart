import 'dart:typed_data';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnnotateImageRepository {
  final functions = FirebaseFunctions.instanceFor(region: "us-central1");
  Future<String?> annotateImage(Uint8List data) async {
    final result = await functions.httpsCallable('annotateImage').call(data);
    return result.data;
  }
}

final annotateImageRepositoryProvider = Provider((ref) {
  return AnnotateImageRepository();
});
