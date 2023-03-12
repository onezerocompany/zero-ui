import 'package:zero_flutter/zero_flutter.dart';
import 'package:cross_file/cross_file.dart';

import '../main.dart';

PageMetadata cropperPageMetadata(Locale locale) {
  return const PageMetadata(
    path: "/cropper",
    icon: Icons.crop,
    name: "Cropper",
    description: "Used for cropping images.",
  );
}

class CropperPage extends Cropper {
  CropperPage(
    super.state, {
    super.metadata = cropperPageMetadata,
    super.key,
  }) : super(
          ratio: 1,
          file: XFile.fromData(testImageBytes!),
        );
}
