import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zero_flutter/zero_flutter.dart';
import 'package:flutter/material.dart' as material;

class OmniSearch extends ConsumerStatefulWidget {
  const OmniSearch({
    super.key,
    required this.text,
  });

  final TextTheme text;

  static const height = AdaptiveValue<double>(
    defaultValue: 48,
    values: [],
  );

  @override
  ConsumerState<OmniSearch> createState() => _OmniSearchState();
}

class _OmniSearchState extends ConsumerState<OmniSearch> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = ref.read(omniBarQuery);
  }

  @override
  Widget build(BuildContext context) {
    final breakpoint = AdaptiveContext.breakpoint(context);
    final colors = Theme.of(context).colorScheme;
    final searching = ref.watch(omniSearching);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Focus(
      onFocusChange: (focus) {
        if (focus) {
          ref.read(omniBarOpen.notifier).state = true;
        }
      },
      child: SizedBox(
        height: OmniSearch.height.value(breakpoint),
        child: AnimatedGlass(
          state: searching ? GlassState.invisible : GlassState.translucent,
          color: isDark ? colors.surface : colors.background,
          transparency: 0.8,
          cornerRadius: AdaptiveValue.fixed(
            BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                child: IconButton(
                  config: IconButton.defaultConfig.copyWith(
                    size: ButtonSize.small,
                    transparency: 1,
                  ),
                  icon: Icons.search,
                  onPressed: () {
                    omnibarFocus.requestFocus();
                  },
                ),
              ),
              Expanded(
                child: Focus(
                  onFocusChange: (focus) {
                    ref.read(omniSearching.notifier).state = focus;
                  },
                  child: material.TextField(
                    clipBehavior: Clip.none,
                    focusNode: omniSearchFocus,
                    controller: controller,
                    enableSuggestions: true,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      border: InputBorder.none,
                      hintStyle: widget.text.titleMedium?.copyWith(
                        color: colors.onSurface.withOpacity(0.5),
                        height: 1,
                        fontSize: 18,
                      ),
                      hintText:
                          ZeroUIAppLocalizations.of(context)!.omniSearchField,
                    ),
                    cursorColor: colors.onSurface,
                    cursorHeight: 16,
                    maxLines: 1,
                    minLines: 1,
                    style: widget.text.titleMedium?.copyWith(
                      color: colors.onSurface,
                      height: 1,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    onChanged: (value) {
                      ref.read(omniBarQuery.notifier).state = value;
                    },
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: searching ? 1 : 0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 12.0,
                    left: 8.0,
                  ),
                  child: IconButton(
                    icon: Icons.clear,
                    config: IconButton.defaultConfig.copyWith(
                      size: ButtonSize.small,
                      transparency: 1,
                    ),
                    onPressed: () {
                      ref.read(omniBarQuery.notifier).state = "";
                      setState(() {
                        controller.text = "";
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
