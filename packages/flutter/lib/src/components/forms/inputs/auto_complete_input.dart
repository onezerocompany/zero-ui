import 'dart:async';

import 'package:flutter/services.dart';
import 'package:zero_ui/zero_ui.dart';

class AutocompleteInputOption<ValueType> {
  const AutocompleteInputOption({
    required this.value,
    required this.label,
    this.sublabel,
    this.icon,
  });

  final IconData? icon;
  final ValueType value;
  final String label;
  final String? sublabel;
}

class AutocompleteInput<ValueType extends Object>
    extends InputField<ValueType> {
  const AutocompleteInput(
    super.state, {
    super.key,

    // InputField specific
    super.errorBuilder,
    super.alignment = InputFieldAlignment.center,
    super.dense = false,
    super.padding = const EdgeInsets.all(20),
    super.fillColor,
    super.leading,
    super.trailing,
    super.enabled = true,
    super.label,
    super.onSubmitted,

    // TextInput specific
    required this.textForItem,
    required this.optionsBuilder,
    this.placeholder,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
  });

  final String Function(ValueType) textForItem;
  final FutureOr<List<AutocompleteInputOption<ValueType>>> Function(String)
      optionsBuilder;

  final int maxLines;
  final String? placeholder;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget fieldBuilder(
    BuildContext context,
    WidgetRef ref, {
    required InputState<ValueType> state,
    required FocusNode focusNode,
  }) {
    final text = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;
    final color = super.fillColor ??
        (isDark ? colors.background.withBrightness(1.5) : colors.surface);
    final foregroundColor = color.foreground;

    final textController = useTextEditingController();

    final keyboardIndex = useState<int>(0);
    final loading = useState(true);
    final items = useState<List<AutocompleteInputOption<ValueType>>>([]);
    final debounce = useState<Timer?>(null);

    useEffect(
      () {
        keyboardIndex.value = 0;
        return null;
      },
      [items.value],
    );

    useEffect(
      () {
        final text = textForItem(state.value);
        final previousText = textController.text;
        final previousSelection = textController.selection;

        // Calculate the new selection based on the current position of the cursor.
        int newOffset =
            previousSelection.baseOffset - previousText.length + text.length;
        final newSelection =
            TextSelection.collapsed(offset: newOffset.clamp(0, text.length));

        // Update the text controller with the new value and selection.
        textController.value = TextEditingValue(
          text: text,
          selection: newSelection,
        );

        return null;
      },
      [state.value],
    );

    return Column(
      children: [
        Focus(
          canRequestFocus: false,
          descendantsAreFocusable: true,
          onKey: (node, event) {
            if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
              keyboardIndex.value =
                  (keyboardIndex.value + 1).clamp(0, items.value.length - 1);
              return KeyEventResult.handled;
            } else if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
              keyboardIndex.value =
                  (keyboardIndex.value - 1).clamp(0, items.value.length - 1);
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          child: TextField(
            textAlign: alignment == InputFieldAlignment.start ||
                    alignment == InputFieldAlignment.center
                ? TextAlign.start
                : TextAlign.end,
            focusNode: focusNode,
            controller: textController,
            minLines: 1,
            maxLines: maxLines,
            enabled: enabled,
            textInputAction: textInputAction,
            enableSuggestions: false,
            keyboardType: keyboardType,
            cursorColor: foregroundColor,
            inputFormatters: inputFormatters,
            onChanged: (text) async {
              loading.value = false;
              debounce.value?.cancel();
              debounce.value =
                  Timer(const Duration(milliseconds: 500), () async {
                if (text.isNotEmpty) {
                  loading.value = true;
                  items.value = await optionsBuilder(text);
                  loading.value = false;
                } else {
                  items.value = [];
                }
              });
            },
            onSubmitted: (text) {
              if (items.value.length > keyboardIndex.value) {
                state.value = items.value[keyboardIndex.value].value;
                super.onSubmittedField(state.value);
              }
            },
            style: text.bodyLarge?.copyWith(
              color: foregroundColor,
              height: 1,
            ),
            decoration: InputDecoration.collapsed(
              hintText: placeholder,
              hintStyle: text.bodyLarge?.copyWith(
                color: foregroundColor.withOpacity(0.5),
                height: 1,
              ),
            ),
          ),
        ),
        AnimatedHider(
          visible: (loading.value || items.value.isNotEmpty) &&
              textController.text.isNotEmpty &&
              focusNode.hasFocus,
          child: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Section(
              children: [
                AnimatedHider(
                  visible: loading.value,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colors.background.withOpacity(0.5),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Center(child: Loader()),
                    ),
                  ),
                ),
                AnimatedHider(
                  visible: items.value.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Section(
                      children: items.value
                          .map(
                            (item) => ListItem(
                              config: ListItem.defaultConfig.copyWith(
                                paddings: {
                                  ButtonSize.small: const EdgeInsets.all(12),
                                  ButtonSize.medium: const EdgeInsets.all(12),
                                  ButtonSize.large: const EdgeInsets.all(12),
                                },
                                textIconSizes: {
                                  ButtonSize.small: 14,
                                  ButtonSize.medium: 14,
                                  ButtonSize.large: 14,
                                },
                                fillColor: colors.background,
                                transparency: keyboardIndex.value ==
                                        items.value.indexOf(item)
                                    ? 0
                                    : 0.5,
                                cornerRadii: {
                                  ButtonSize.small: BorderRadius.circular(8),
                                  ButtonSize.medium: BorderRadius.circular(8),
                                  ButtonSize.large: BorderRadius.circular(8),
                                },
                                borderWidth: 2,
                                borderColor: keyboardIndex.value ==
                                        items.value.indexOf(item)
                                    ? colors.onBackground.withOpacity(0.3)
                                    : Colors.transparent,
                              ),
                              label: item.label,
                              sublabel: item.sublabel,
                              leading: item.icon,
                              onPressed: () {
                                state.value = item.value;
                                focusNode.unfocus();
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
