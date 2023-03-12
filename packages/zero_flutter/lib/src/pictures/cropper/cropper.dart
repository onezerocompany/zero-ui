import 'package:camera/camera.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:zero_flutter/zero_flutter.dart' hide Image;
import 'package:zero_flutter/src/pictures/cropper/render_image.dart';

class Cropper extends Page {
  final XFile file;
  final double? ratio;
  final editorKey = GlobalKey<ExtendedImageEditorState>();
  final gestureKey = GlobalKey<ExtendedImageGestureState>();
  final fileBytes =
      FutureProvider.autoDispose.family<Uint8List, XFile>((ref, file) async {
    return file.readAsBytes();
  });
  final processing = StateProvider.autoDispose<bool>((ref) => false);

  @override
  PageLayout get layout => PageLayout.card;

  Cropper(
    super.state, {
    required super.metadata,
    super.key,
    required this.file,
    this.ratio,
  });

  Future<XFile?> renderCroppedImage() async {
    var state = editorKey.currentState;
    var action = state?.editAction;

    if (state == null || action == null) return null;
    Map<String, dynamic> instructions = {
      "img": state.rawImageData,
    };

    if (action.needCrop) {
      final rect = state.getCropRect() ?? Rect.zero;
      instructions["cropRect"] = {
        "left": rect.left.toInt(),
        "top": rect.top.toInt(),
        "width": rect.width.toInt(),
        "height": rect.height.toInt(),
      };
    }

    if (action.needFlip) {
      instructions["flip"] = {
        "x": action.flipX,
        "y": action.flipY,
      };
    }

    if (action.hasRotateAngle) {
      instructions["rotateAngle"] = action.rotateAngle;
    }

    XFile? rendered = await compute(renderImage, instructions);
    return rendered;
  }

  @override
  PageContentBuilder? get contentBuilder => ((context, ref, landscape) {
        ColorScheme colors = Theme.of(context).colorScheme;
        AsyncValue<Uint8List> bytes = ref.watch(fileBytes(file));
        return PageContent(
          scrollable: false,
          extend: true,
          child: bytes.when(
            loading: () => const Center(
              child: Loader(),
            ),
            error: (error, stack) {
              return Center(
                child: Text('Error loading image, ${error.toString()}'),
              );
            },
            data: (bytes) => ClipRRect(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ExtendedImage.memory(
                    bytes,
                    fit: BoxFit.contain,
                    mode: ExtendedImageMode.editor,
                    clipBehavior: Clip.none,
                    extendedImageEditorKey: editorKey,
                    extendedImageGestureKey: gestureKey,
                    initEditorConfigHandler: (state) {
                      return EditorConfig(
                        reverseMousePointerScrollDirection: true,
                        cropAspectRatio: ratio,
                        initCropRectType: InitCropRectType.layoutRect,
                        cropRectPadding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top + 94,
                          bottom: MediaQuery.of(context).padding.bottom + 128,
                          left: MediaQuery.of(context).padding.left + 16,
                          right: MediaQuery.of(context).padding.right + 16,
                        ),
                        cornerColor: colors.onBackground,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      });

  // @override
  // BottomBarBuilder? get bottomBarBuilder => ((context, ref) {
  //       bool isProcessing = ref.watch(processing);
  //       return BottomBar(
  //         actionButton: ActionButton(
  //           position: ActionButtonPosition.end,
  //           loading: isProcessing,
  //           icon: Icons.check,
  //           onPressed: () async {
  //             final router = AppData.router(context);
  //             ref.read(processing.notifier).state = true;
  //             XFile? rendered = await renderCroppedImage();
  //             if (rendered != null && router.router.canPop() == true) {
  //               router.router.pop(rendered);
  //             }
  //             ref.read(processing.notifier).state = false;
  //           },
  //         ),
  //         items: [
  //           BottomBarItem(
  //             icon: Icons.rotate_left,
  //             onPressed: () {
  //               editorKey.currentState?.rotate(right: false);
  //             },
  //           ),
  //           BottomBarItem(
  //             icon: Icons.rotate_right,
  //             onPressed: () {
  //               editorKey.currentState?.rotate(right: true);
  //             },
  //           ),
  //           BottomBarItem(
  //             icon: Icons.flip,
  //             onPressed: () {
  //               editorKey.currentState?.flip();
  //             },
  //           ),
  //           BottomBarItem(
  //             icon: Icons.refresh,
  //             onPressed: () {
  //               editorKey.currentState?.reset();
  //             },
  //           ),
  //         ],
  //       );
  //     });
}
