import 'package:zero_flutter/zero_flutter.dart';

class CameraPage extends CameraScreen {
  const CameraPage({
    super.key,
  });

  @override
  PageMetadata metadata(BuildContext context) {
    return PageMetadata(
      path: "/camera",
      icon: Icons.camera,
      name: (context) => "Camera",
      description: (context) =>
          "Used for capturing images and videos from the device's camera.",
    );
  }
}
