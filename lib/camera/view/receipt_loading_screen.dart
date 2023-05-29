import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_ocr_practice/camera/model/camera_provider.dart';
import 'package:for_ocr_practice/camera/view/component/take_picture_button.dart';

class ReceiptLoadingScreen extends ConsumerWidget {
  const ReceiptLoadingScreen({super.key});

  final double bottomCameraContainerHeight = 100;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraController = ref.watch(cameraControllerFutureProvider);
    return SafeArea(
      child: Scaffold(
        body: cameraController.when(
          data: (data) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: (data.value.aspectRatio),
                    child: CameraPreview(data),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: bottomCameraContainerHeight,
                  color: Colors.black,
                  child: Center(
                    child: TakePictureButton(controller: data),
                  ),
                )
              ],
            );
          },
          error: (error, stackTrace) {
            debugPrint(error.toString());
            return null;
          },
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
