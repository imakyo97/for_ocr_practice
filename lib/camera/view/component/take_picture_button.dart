import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_ocr_practice/camera/model/annotate_image_provider.dart';
import 'package:for_ocr_practice/camera/model/auth_provider.dart';
import 'package:for_ocr_practice/read_result/model/full_text_provider.dart';
import 'package:for_ocr_practice/router/pages_management.dart';

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
            await ref.read(authProvider.notifier).checkAuth();
            // 写真を撮影し、OCRを実行
            await executeOCR(ref);
            ref.read(pagesManagementProvider.notifier).openReadResult();
          } catch (e) {
            debugPrint(e.toString());
          }
        },
        child: const Icon(Icons.camera_alt_outlined),
      ),
    );
  }

  Future<void> executeOCR(WidgetRef ref) async {
    final imageFileNotifier = ref.read(imageXFileProvider.notifier);
    imageFileNotifier.state = await controller.takePicture();
    await controller.pausePreview();
    final fullTextNotifier = ref.read(fullTextProvider.notifier);
    fullTextNotifier.state = await ref.read(annotateImageFutureProvider.future);
  }
}
