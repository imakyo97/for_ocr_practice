import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraView extends StatelessWidget {
  const CameraView({
    super.key,
    required this.cameraController,
  });

  final CameraController? cameraController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: cameraController == null
          ? Container()
          : AspectRatio(
              aspectRatio: (cameraController!.value.aspectRatio),
              child: CameraPreview(cameraController!),
            ),
    );
  }
}
