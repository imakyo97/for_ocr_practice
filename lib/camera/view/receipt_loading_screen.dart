import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_ocr_practice/camera/model/camera_provider.dart';
import 'package:for_ocr_practice/camera/view/component/take_picture_button.dart';

class ReceiptLoadingScreen extends ConsumerWidget {
  const ReceiptLoadingScreen({super.key});

  final double _bottomCameraContainerHeight = 100;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraController =
        ref.watch(cameraControllerProvider.notifier).initialize();
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: cameraController,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (snapshot.hasData) {
              if (snapshot.data == null) {
                return const Center(
                  child: Text('カメラ起動に失敗しました'),
                );
              }
              final data = snapshot.data!;
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
                    height: _bottomCameraContainerHeight,
                    color: Colors.black,
                    child: Center(
                      child: TakePictureButton(controller: data),
                    ),
                  )
                ],
              );
            }

            return const Center(
              child: Text('カメラ起動に失敗しました'),
            );
          },
        ),
      ),
    );
  }
}
