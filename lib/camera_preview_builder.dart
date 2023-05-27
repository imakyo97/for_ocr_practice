import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewBuilder extends StatelessWidget {
  const CameraPreviewBuilder({
    super.key,
    required Future<void> initializeControllerFuture,
    required this.controller,
  }) : _initializeControllerFuture = initializeControllerFuture;

  final Future<void> _initializeControllerFuture;
  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final size = MediaQuery.of(context).size;
          return Expanded(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: size.width,
                height: size.width * controller.value.aspectRatio,
                child: AspectRatio(
                  aspectRatio: 1 / controller.value.aspectRatio,
                  child: CameraPreview(controller),
                ),
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
