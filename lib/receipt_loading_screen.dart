import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:for_ocr_practice/take_picture_button.dart';

import 'camera_preview_builder.dart';

class ReceiptLoadingScreen extends StatefulWidget {
  const ReceiptLoadingScreen({super.key});

  @override
  State<ReceiptLoadingScreen> createState() => _ReceiptLoadingScreenState();
}

class _ReceiptLoadingScreenState extends State<ReceiptLoadingScreen> {
  late CameraController controller;
  late Future<void> _initializeControllerFuture;
  bool _isCameraReady = false;

  final double bottomCameraContainerHeight = 100;

  @override
  void initState() {
    super.initState();
    _initalizeCamera();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          if (_isCameraReady) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CameraPreviewBuilder(
                  initializeControllerFuture: _initializeControllerFuture,
                  controller: controller,
                ),
                Container(
                  width: double.infinity,
                  height: bottomCameraContainerHeight,
                  color: Colors.black,
                  child: Center(
                    child: TakePictureButton(controller: controller),
                  ),
                )
              ],
            );
          }
          return const Center(child: Text('カメラが起動できませんでした。'));
        }),
      ),
    );
  }

  Future<void> _initalizeCamera() async {
    final cameras = await availableCameras();
    controller = CameraController(
      cameras.first,
      ResolutionPreset.veryHigh,
      enableAudio: false,
    );
    _initializeControllerFuture = controller.initialize();
    setState(() {
      _isCameraReady = true;
    });
  }
}
