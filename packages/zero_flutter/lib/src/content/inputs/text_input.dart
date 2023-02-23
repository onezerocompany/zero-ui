import 'dart:math';

import 'package:flutter/services.dart';
import 'package:zero_flutter/zero_flutter.dart';

class TextInput extends InputField<String> {
  const TextInput(
    BuildContext context, {
    super.key,
    super.controller,

    // InputField specific
    required super.id,
    super.validator,
    super.errorBuilder,
    super.alignment = InputFieldAlignment.center,
    super.dense = false,
    super.padding = const EdgeInsets.all(20),
    super.fillColor,
    super.leading,
    super.trailing,
    super.enabled = true,
    super.label,
    super.sanitizer,
    super.onSubmitted,

    // TextInput specific
    this.placeholder,
    this.textInputAction,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autofillHints,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  String defaultValue() {
    return '';
  }

  final String? placeholder;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enableSuggestions;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  InputFieldState<String, TextInput> createState() {
    return _TextInputState();
  }
}

class _TextInputState extends InputFieldState<String, TextInput> {
  final _controller = TextEditingController();

  @override
  void stateUpdated(InputState<String> state) {
    super.stateUpdated(state);
    final selection = _controller.selection;
    final extraChars = (state.value.length - _controller.text.length);
    _controller.text = state.value;
    // make sure the cursor is at the previous position
    // if the text was longer than the previous value
    // add the difference to the offset
    _controller.selection = TextSelection.fromPosition(
      TextPosition(
        offset: min(
          selection.baseOffset + extraChars,
          _controller.text.length,
        ),
      ),
    );
  }

  @override
  Widget fieldBuilder(
    BuildContext context, {
    required InputState<String> state,
    required FocusNode focusNode,
  }) {
    final text = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;
    final color = super.widget.fillColor ??
        (isDark ? colors.background.withBrightness(1.5) : colors.surface);
    final foregroundColor = color.foreground;

    return TextField(
      textAlign: widget.alignment == InputFieldAlignment.start ||
              widget.alignment == InputFieldAlignment.center
          ? TextAlign.start
          : TextAlign.end,
      focusNode: fieldFocusNode,
      controller: _controller,
      enabled: widget.enabled,
      obscureText: widget.obscureText,
      textInputAction: widget.textInputAction,
      enableSuggestions: widget.enableSuggestions,
      autofillHints: widget.autofillHints,
      keyboardType: widget.keyboardType,
      cursorColor: foregroundColor,
      inputFormatters: widget.inputFormatters,
      style: text.bodyLarge?.copyWith(
        color: foregroundColor,
        height: 1,
      ),
      onChanged: (value) {
        widget
            .effectiveController(context)
            ?.updateValue<String>(widget.id, value);
      },
      onSubmitted: (value) => onSubmittedField(value),
      decoration: InputDecoration.collapsed(
        hintText: widget.placeholder,
        hintStyle: text.bodyLarge?.copyWith(
          color: foregroundColor.withOpacity(0.3),
          height: 1,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
