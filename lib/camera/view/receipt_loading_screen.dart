import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_ocr_practice/camera/view/component/take_picture_button.dart';

import 'component/camera_preview_builder.dart';

class ReceiptLoadingScreen extends ConsumerStatefulWidget {
  const ReceiptLoadingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReceiptLoadingScreenState();
}

class _ReceiptLoadingScreenState extends ConsumerState<ReceiptLoadingScreen> {
  late CameraController controller;
  late Future<void> _initializeControllerFuture;
  bool _isCameraReady = false;

  final double bottomCameraContainerHeight = 100;

  // TODO: initStateの処理をProviderでするように修正し、ConsumerWidgetに変える
  @override
  void initState() {
    super.initState();
    _signIn();
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
                Expanded(
                  child: CameraPreviewBuilder(
                    initializeControllerFuture: _initializeControllerFuture,
                    controller: controller,
                  ),
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

  void _signIn() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  Future<void> _initalizeCamera() async {
    final cameras = await availableCameras();
    controller = CameraController(
      cameras.first,
      // ここを変えるとcontrollerのpreviewSizeも変わる
      ResolutionPreset.veryHigh,
      enableAudio: false,
    );
    _initializeControllerFuture = controller.initialize();
    setState(() {
      _isCameraReady = true;
    });
  }
}
