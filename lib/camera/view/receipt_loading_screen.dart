import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_ocr_practice/camera/model/camera_provider.dart';
import 'package:for_ocr_practice/camera/view/component/camera_view.dart';
import 'package:for_ocr_practice/camera/view/component/take_picture_button.dart';

class ReceiptLoadingScreen extends ConsumerStatefulWidget {
  const ReceiptLoadingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReceiptLoadingScreenState();
}

class _ReceiptLoadingScreenState extends ConsumerState<ReceiptLoadingScreen> {
  final double _bottomCameraContainerHeight = 100;

  @override
  void initState() {
    super.initState();
    ref.read(cameraControllerProvider.notifier).initialize();
  }

  @override
  Widget build(BuildContext context) {
    final cameraController = ref.watch(cameraControllerProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CameraView(cameraController: cameraController),
            Container(
              width: double.infinity,
              height: _bottomCameraContainerHeight,
              color: Colors.black,
              child: Center(
                child: TakePictureButton(controller: cameraController),
              ),
            )
          ],
        ),
      ),
    );
  }
}
