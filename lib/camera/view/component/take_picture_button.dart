import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_ocr_practice/camera/model/annotate_image_provider.dart';
import 'package:for_ocr_practice/camera/model/auth_provider.dart';

class TakePictureButton extends ConsumerWidget {
  const TakePictureButton({super.key, required this.controller});

  final CameraController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            // OCR実行には認証が必須なため、認証を確認
            await checkAuth(ref);
            // 写真を撮影し、OCRを実行
            final fullText = await executeOCR(ref);
            debugPrint('💩: ${fullText}');
          } catch (e) {
            debugPrint(e.toString());
          }
        },
        child: const Icon(Icons.camera_alt_outlined),
      ),
    );
  }

  Future<void> checkAuth(WidgetRef ref) async {
    final authNotifier = ref.watch(authProvider.notifier);
    if (!authNotifier.isLogin()) {
      await authNotifier.signIn();
    }
  }

  Future<String?> executeOCR(WidgetRef ref) async {
    final imageDataNotifier = ref.watch(annotateImageDataProvider.notifier);
    final XFile image = await controller.takePicture();
    final Uint8List bytes = await image.readAsBytes();
    imageDataNotifier.state = bytes;
    return await ref.read(annotateImageFutureProvider.future);
  }
}
