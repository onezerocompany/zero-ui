import 'package:zero_ui/zero_ui.dart';

class PageStructure extends StatelessWidget {
  const PageStructure({
    Key? key,
    this.landscape = false,
    this.layout = PageLayout.fullscreen,
    this.content,
    this.topBar,
  }) : super(key: key);

  final bool landscape;
  final PageLayout layout;
  final PageContent? content;
  final TopBar? topBar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topBar ?? const SizedBox.shrink(),
        Expanded(
          child: LayoutBuilder(
            builder: (
              context,
              constraints,
            ) {
              return Stack(
                children: [
                  layout == PageLayout.card
                      ? FadedContainer(
                          fade: content?.fadeEdges == false
                              ? EdgeInsets.zero
                              : const EdgeInsets.only(
                                  top: 60,
                                  bottom: 60,
                                ),
                          blur: content?.fadeEdges == false
                              ? EdgeInsets.zero
                              : const EdgeInsets.only(
                                  top: 60,
                                  bottom: 60,
                                ),
                          child: Center(
                            child: content,
                          ),
                        )
                      : Center(
                          child: content,
                        ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
