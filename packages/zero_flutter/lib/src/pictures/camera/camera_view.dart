import 'dart:ui';

import 'package:camera/camera.dart' hide CameraPreview;
import 'package:zero_flutter/zero_flutter.dart';

import 'camera_preview.dart';

class CameraView extends StatefulWidget {
  const CameraView({
    super.key,
  });

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  List<CameraDescription> cameras = [];
  CameraDescription? currentCamera;
  CameraController? controller;

  initialize() async {
    cameras = await availableCameras();
    if (cameras.isEmpty) return;
    await selectCamera();
  }

  @override
  dispose() {
    super.dispose();
    controller?.dispose();
  }

  // Whether the control is ready to show a camera feed
  // and/or take pictures
  bool get isReady {
    return controller?.value.isInitialized ?? false;
  }

  Future<XFile?> takePicture() async {
    if (!isReady) return null;
    return await controller?.takePicture();
  }

  // select a camera
  selectCamera({direction = CameraLensDirection.back, String? name}) async {
    if (name != null) {
      currentCamera = cameras.firstWhere(
        (camera) {
          return camera.name == name;
        },
        orElse: () => cameras.first,
      );
    } else {
      // otherwise, select the first camera with the given direction
      currentCamera = cameras.firstWhere(
        (camera) {
          return camera.lensDirection == direction;
        },
        orElse: () => cameras.first,
      );
    }

    if (currentCamera == null) return;

    controller = CameraController(currentCamera!, ResolutionPreset.max);
    await controller?.initialize();
    setState(() {});
    await setFlash(FlashMode.off);
  }

  camerasForDirection() {
    return cameras.where((camera) {
      return camera.lensDirection == currentCamera?.lensDirection;
    }).toList();
  }

  cycleCamera() {
    var cameras = camerasForDirection();
    var index = cameras.indexOf(currentCamera);
    if (index == cameras.length - 1) {
      selectCamera(name: cameras.first.name);
    } else {
      selectCamera(name: cameras[index + 1].name);
    }
  }

  toggleCameraDirection() {
    if (currentCamera?.lensDirection == CameraLensDirection.back) {
      selectCamera(direction: CameraLensDirection.front);
    } else {
      selectCamera(direction: CameraLensDirection.back);
    }
  }

  FlashMode get flashMode {
    return controller?.value.flashMode ?? FlashMode.off;
  }

  // flash control
  setFlash(FlashMode mode) async {
    try {
      await controller?.setFlashMode(mode);
    } on CameraException catch (e) {
      if (e.code == 'setFlashModeFailed') {
        await controller?.setFlashMode(FlashMode.off);
      }
    } catch (_) {}
    setState(() {});
  }

  cycleFlash() async {
    switch (flashMode) {
      case FlashMode.off:
        await setFlash(FlashMode.auto);
        break;
      case FlashMode.auto:
        await setFlash(FlashMode.always);
        break;
      case FlashMode.always:
        await setFlash(FlashMode.torch);
        break;
      case FlashMode.torch:
        await setFlash(FlashMode.off);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: 0.5,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: CameraPreview(
              controller: controller,
              isReady: isReady,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: AspectRatio(
            aspectRatio: 1,
            child: AnimatedSmoothCorner(
              cornerRadius: BorderRadius.circular(22),
              child: CameraPreview(
                controller: controller,
                isReady: isReady,
                showLoading: true,
              ),
            ),
          ),
        ),
        Column(
          children: const [
            Spacer(),
          ],
        ),
      ],
    );
  }
}
