import 'package:zero_flutter/zero_flutter.dart';

PageMetadata cameraPageMetadata(Locale locale) {
  return const PageMetadata(
    path: "/camera",
    icon: Icons.camera,
    name: "Camera",
    description:
        "Used for capturing images and videos from the device's camera.",
  );
}

class CameraPage extends CameraScreen {
  const CameraPage(
    super.state, {
    super.metadata = cameraPageMetadata,
    super.key,
  });
}
