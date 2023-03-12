import 'package:zero_flutter/globals.dart';
import 'package:zero_flutter/zero_flutter.dart';
import 'package:smooth_corner/smooth_corner.dart';

class TopBar extends ConsumerWidget {
  final String? title;
  final String? subtitle;
  final bool backButton;
  final Widget? trailing;
  final StatusBarStyle? statusBarStyle;
  final Color backgroundColor;
  final bool isCard;

  const TopBar({
    super.key,
    this.backButton = true,
    this.title,
    this.subtitle,
    this.trailing,
    this.statusBarStyle,
    this.backgroundColor = Colors.transparent,
    this.isCard = false,
  });

  bool get isVisible {
    return title != null ||
        subtitle != null ||
        trailing != null ||
        backButton == true;
  }

  copyWith({
    String? title,
    String? subtitle,
    bool? backButton,
    Widget? trailing,
    StatusBarStyle? statusBarStyle,
    GlobalKey? topBarKey,
    Color? backgroundColor,
  }) {
    return TopBar(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      backButton: backButton ?? this.backButton,
      trailing: trailing ?? this.trailing,
      statusBarStyle: statusBarStyle ?? this.statusBarStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final panels = ref.watch(panelsProvider);
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      bottom: false,
      top: !isCard,
      minimum: const EdgeInsets.only(top: 14),
      child: Padding(
        padding: EdgeInsets.only(
          left: 22,
          right: 22,
          bottom: 4,
          top: height > 500 ? 12 : 0,
        ),
        child: Builder(
          builder: (context) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                if (title != null)
                  SmoothContainer(
                    smoothness: smoothness,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    child: Column(
                      children: [
                        Text(
                          title!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                height: 1,
                              ),
                        ),
                        if (subtitle != null)
                          const SizedBox.square(dimension: 4),
                        if (subtitle != null)
                          Text(
                            subtitle!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  height: 1,
                                ),
                          ),
                      ],
                    ),
                  ),
                // if back button is enabled, and page can be popped
                Row(
                  children: [
                    if (Navigator.canPop(context))
                      IconButton(
                        config: IconButton.defaultConfig.copyWith(
                          transparency: 1,
                        ),
                        icon: panels >= 2 ? Icons.close : Icons.arrow_back,
                        onPressed: () {
                          Navigator.of(context).maybePop();
                        },
                      ),
                    const Spacer(),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

typedef TopBarBuilder = TopBar? Function(
  BuildContext context,
  WidgetRef ref,
);
