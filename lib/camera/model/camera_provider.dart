import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CameraControllerNotifier extends StateNotifier<CameraController?> {
  CameraControllerNotifier() : super(null);

  Future<CameraController> initialize() async {
    final cameras = await availableCameras();
    final cameraController = CameraController(
      cameras.first,
      // ここを変えるとcontrollerのpreviewSizeも変わる
      ResolutionPreset.veryHigh,
      enableAudio: false,
    );
    await cameraController.initialize();
    state = cameraController;
    return cameraController;
  }
}

final cameraControllerProvider = StateNotifierProvider.autoDispose<
    CameraControllerNotifier, CameraController?>((ref) {
  return CameraControllerNotifier();
});
