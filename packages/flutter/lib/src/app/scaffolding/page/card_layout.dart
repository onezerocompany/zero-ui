import 'package:zero_ui/globals.dart';
import 'package:zero_ui/zero_ui.dart';

part 'card_layout.g.dart';

@riverpod
BorderRadius pageCardCorner(PageCardCornerRef ref) {
  final breakpoint = ref.watch(breakPointProvider);
  return const AdaptiveValue<BorderRadius>(
    fallbackValue: BorderRadius.zero,
    values: [
      AdaptiveRangedValue(
        minBreakpoint: BreakPoint.md,
        value: BorderRadius.all(Radius.circular(16)),
      ),
      AdaptiveRangedValue(
        minBreakpoint: BreakPoint.xl,
        value: BorderRadius.all(Radius.circular(24)),
      ),
    ],
  ).value(breakpoint);
}

class PageCardLayout extends ConsumerWidget {
  const PageCardLayout({
    super.key,
    this.layout = PageLayout.fullscreen,
    required this.structure,
    required this.cardColor,
    required this.backgroundColor,
  });

  final PageStructure structure;
  final PageLayout layout;
  final Color cardColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cornerRadius = ref.watch(pageCardCornerProvider);
    if (layout == PageLayout.card || layout == PageLayout.fullscreenCard) {
      final padding = PageContent.padding(
        context,
        ref,
        extend: structure.content?.extend ?? false,
        fadeEdges: false,
        layout: PageLayout.fullscreen,
        offsetBar: false,
      );
      return AnimatedPadding(
        duration: pageTransitionDuration,
        curve: pageTransitionCurve,
        padding: layout == PageLayout.fullscreenCard
            ? EdgeInsets.zero
            : EdgeInsets.only(
                top: padding.top,
                right: padding.right,
                bottom: padding.bottom,
              ),
        child: Glass(
          state: GlassState.translucent,
          cornerRadius: cornerRadius,
          transparency: 0.8,
          child: structure,
        ),
      );
    } else {
      return AnimatedContainer(
        duration: pageTransitionDuration,
        curve: Curves.easeInOut,
        color: backgroundColor,
        child: structure,
      );
    }
  }
}
