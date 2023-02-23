import 'package:zero_flutter/zero_flutter.dart';
import 'package:cross_file/cross_file.dart';

import '../main.dart';

class CropperPage extends Cropper {
  CropperPage({super.key})
      : super(
          ratio: 1,
          file: XFile.fromData(testImageBytes!),
        );

  @override
  PageMetadata metadata(BuildContext context) {
    return PageMetadata(
      path: '/cropper',
      icon: Icons.crop,
      name: (context) => 'Image Cropper',
      description: (context) => 'Crop an image',
    );
  }
}
