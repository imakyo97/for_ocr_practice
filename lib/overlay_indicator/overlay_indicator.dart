import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_ocr_practice/camera/model/annotate_image_provider.dart';

class OverlayIndicator extends StatelessWidget {
  const OverlayIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.black26,
      child: SizedBox.expand(
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}

final shouldDisplayOverlayIndicatorProvider =
    StateProvider.autoDispose<bool>((ref) {
  return ref
      .watch(annotateImageFutureProvider.select((value) => value.isLoading));
});
