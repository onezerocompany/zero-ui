import 'package:camera/camera.dart';
import 'package:zero_flutter/zero_flutter.dart';
import 'package:camera/camera.dart' as camera;

class CameraPreview extends StatelessWidget {
  final CameraController? controller;
  final bool isReady;
  final BoxFit fit;
  final bool showLoading;

  const CameraPreview({
    super.key,
    required this.controller,
    required this.isReady,
    this.fit = BoxFit.cover,
    this.showLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (!isReady || controller == null) {
      return Container(
        constraints: const BoxConstraints.expand(),
        child: showLoading
            ? const Center(
                child: Loader(),
              )
            : null,
      );
    } else {
      return SizedBox(
        width: size.width,
        height: size.height,
        child: FittedBox(
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.center,
          fit: fit,
          child: SizedBox(
            width: 1,
            child: camera.CameraPreview(controller!),
          ),
        ),
      );
    }
  }
}
