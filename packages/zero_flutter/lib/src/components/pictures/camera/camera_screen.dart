import 'package:zero_flutter/zero_flutter.dart';

import 'camera_view.dart';

class CameraScreen extends Page {
  const CameraScreen(
    super.state, {
    required super.metadata,
    super.key,
  });

  @override
  PageLayout get layout => PageLayout.card;

  @override
  PageContentBuilder? get contentBuilder => (context, ref, landscape) {
        return const PageContent(
          scrollable: false,
          backgroundColor: Colors.black,
          child: CameraView(),
        );
      };
}
