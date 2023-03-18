import 'package:flutter/services.dart';
import 'package:zero_flutter/zero_flutter.dart';

class LocalizedTextInput extends InputField<LocalizedString> {
  const LocalizedTextInput(
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

    // LocalizedTextInput specific
    required this.currentLocale,
    this.placeholder,
    this.textInputAction,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autofillHints,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
  });

  final Locale currentLocale;
  final int maxLines;
  final String? placeholder;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enableSuggestions;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget fieldBuilder(
    BuildContext context,
    WidgetRef ref, {
    required InputState<LocalizedString> state,
    required FocusNode focusNode,
  }) {
    final text = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;
    final color = super.fillColor ??
        (isDark ? colors.background.withBrightness(1.5) : colors.surface);
    final foregroundColor = color.foreground;
    final textController = useTextEditingController(
      text: state.value.get(currentLocale),
    );

    useEffect(
      () {
        final text = state.value.get(currentLocale);
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
      [currentLocale, state.value],
    );

    return TextField(
      textAlign: alignment == InputFieldAlignment.start ||
              alignment == InputFieldAlignment.center
          ? TextAlign.start
          : TextAlign.end,
      focusNode: focusNode,
      controller: textController,
      minLines: 1,
      maxLines: maxLines,
      enabled: enabled,
      obscureText: obscureText,
      textInputAction: textInputAction,
      enableSuggestions: enableSuggestions,
      autofillHints: autofillHints,
      keyboardType: keyboardType,
      cursorColor: foregroundColor,
      inputFormatters: inputFormatters,
      style: text.bodyLarge?.copyWith(
        color: foregroundColor,
        height: 1,
      ),
      onChanged: (value) {
        state.value = state.value..set(currentLocale, value);
      },
      onSubmitted: (value) => onSubmittedField.call(state.value),
      decoration: InputDecoration.collapsed(
        hintText: placeholder,
        hintStyle: text.bodyLarge?.copyWith(
          color: foregroundColor.withOpacity(0.3),
          height: 1,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
