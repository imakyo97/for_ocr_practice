import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePictureButton extends StatelessWidget {
  const TakePictureButton({
    super.key,
    required this.controller,
  });

  final CameraController controller;

  @override
  Widget build(BuildContext context) {
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
        onPressed: () {
          // TODO: カメラ撮影機能を実装
        },
        child: const Icon(Icons.camera_alt_outlined),
      ),
    );
  }
}
