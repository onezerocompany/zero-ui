import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:image/image.dart';

Future<XFile?> renderImage(
  Map<String, dynamic> instructions,
) async {
  final img = instructions['img'];
  if (img == null) return null;

  var src = decodeImage(img);
  if (src == null) return null;
  src = bakeOrientation(src);

  if (instructions["cropRect"] != null) {
    final rect = instructions["cropRect"];
    src = copyCrop(
      src,
      x: rect["left"].toInt(),
      y: rect["top"].toInt(),
      width: rect["width"].toInt(),
      height: rect["height"].toInt(),
    );
  }

  if (instructions["flip"] != null) {
    FlipDirection mode = FlipDirection.horizontal;
    if (instructions["flip"]["y"] && instructions["flip"]["x"]) {
      mode = FlipDirection.both;
    } else if (instructions["flip"]["y"]) {
      mode = FlipDirection.horizontal;
    } else if (instructions["flip"]["x"]) {
      mode = FlipDirection.vertical;
    }
    src = flip(src, direction: mode);
  }

  if (instructions["rotateAngle"] != null) {
    src = copyRotate(
      src,
      angle: instructions["rotateAngle"],
    );
  }

  Uint8List rendered = encodeJpg(src);
  return XFile.fromData(rendered);
}
