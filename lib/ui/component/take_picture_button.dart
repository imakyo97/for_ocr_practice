import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_ocr_practice/request_provider/annotate_image_provider.dart';

class TakePictureButton extends ConsumerWidget {
  const TakePictureButton({super.key, required this.controller});

  final CameraController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageDataNotifier = ref.watch(annotateImageDataProvider.notifier);
    return SizedBox(
      width: 50,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: const CircleBorder(),
          backgroundColor: Colors.black,
          splashFactory: NoSplash.splashFactory,
          side: const BorderSide(
            color: Colors.white,
            width: 2.5,
          ),
        ),
        onPressed: () async {
          try {
            final XFile image = await controller.takePicture();
            final Uint8List bytes = await image.readAsBytes();
            imageDataNotifier.state = bytes;
            final fullText = await ref.read(annotateImageFutureProvider.future);
            debugPrint('💩: ${fullText}');
          } catch (e) {
            debugPrint(e.toString());
          }
        },
        child: const Icon(Icons.camera_alt_outlined),
      ),
    );
  }
}
