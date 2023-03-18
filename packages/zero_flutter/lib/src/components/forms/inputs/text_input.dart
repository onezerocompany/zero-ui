import 'package:flutter/services.dart';
import 'package:zero_flutter/zero_flutter.dart';

class TextInput extends InputField<String> {
  const TextInput(
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
    this.placeholder,
    this.textInputAction,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autofillHints,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
  });

  final int maxLines;
  final String? placeholder;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enableSuggestions;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  // Adjusts the cursor position when the text is updated
  // From the controller

  @override
  Widget fieldBuilder(
    BuildContext context,
    WidgetRef ref, {
    required InputState<String> state,
    required FocusNode focusNode,
  }) {
    final text = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;
    final color = super.fillColor ??
        (isDark ? colors.background.withBrightness(1.5) : colors.surface);
    final foregroundColor = color.foreground;

    final textController = useTextEditingController();

    useEffect(
      () {
        final text = state.value;
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
      onChanged: (value) => state.value = value,
      onSubmitted: (value) => onSubmittedField.call(value),
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
