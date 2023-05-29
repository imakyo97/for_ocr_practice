import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cameraControllerFutureProvider =
    FutureProvider.autoDispose<CameraController>((ref) async {
  final cameras = await availableCameras();
  final cameraController = CameraController(
    cameras.first,
    // ここを変えるとcontrollerのpreviewSizeも変わる
    ResolutionPreset.veryHigh,
    enableAudio: false,
  );
  await cameraController.initialize();
  return cameraController;
});
