import 'package:zero_ui/zero_ui.dart';

export 'input_state.dart';

/// Alignment of the input field in the container.
enum InputFieldAlignment {
  /// The input field is aligned to the start of the container.
  start,

  /// The input field is aligned to the center of the container.
  center,

  /// The input field is aligned to the end of the container.
  end,
}

/// Input field for any value of type [ValueType].
/// This is a base class for all input fields.
abstract class InputField<ValueType> extends HookConsumerWidget {
  const InputField(
    this.state, {
    super.key,

    // widget related
    this.label,
    this.labelTrailing,
    this.leading,
    this.trailing,
    this.footer,
    this.enabled = true,
    this.alignment = InputFieldAlignment.center,
    this.fillColor,
    this.dense = false,
    this.padding = EdgeInsets.zero,
    this.onSubmitted,
    this.errorBuilder,
    this.focusHighlight = true,
  });

  /// The controller for the input field.
  final InputState<ValueType> state;

  /// Error message builder for the input field.
  /// This is called when the input field is built.
  /// It includes the [BuildContext] and the [String] returned by the validator.
  final String? Function(BuildContext context, String? errorCode)? errorBuilder;

  /// A leading widget for the input field.
  /// This is displayed before the input field.
  /// It also accepts a [IconData] object.
  final dynamic leading;

  /// A trailing widget for the input field.
  /// This is displayed after the input field.
  /// It also accepts a [IconData] object.
  final dynamic trailing;

  /// A pre-trailing widget for the input field.
  /// This is displayed before the input field if [alignment] is `end`.
  /// It also accepts a [IconData] object.
  final dynamic labelTrailing;

  /// Footer widget for the input field.
  /// This is displayed below the input field.
  final Widget? footer;

  /// Whether the input field is enabled.
  /// If this is `false`, the input field will be disabled.
  final bool enabled;

  /// Fill color for the input field.
  /// If this is `null`, the input field will use the default fill color.
  final Color? fillColor;

  /// Input first
  /// This makes the value appear at the beginning of the input field.
  final InputFieldAlignment alignment;

  /// Padding for the input field.
  /// This is the padding around the input field.
  final EdgeInsets padding;

  /// Dense mode for the input field.
  final bool dense;

  /// Label for the input field.
  /// This is displayed above the input field normally.
  /// When [alignment] is `true` this is displayed to the right of
  /// the input field before [trailing].
  final String? label;

  /// Whether to add focus highlight to the input field.
  final bool focusHighlight;

  /// Called when the input field is submitted.
  /// e.g. when the user presses the enter key.
  final Function(ValueType value)? onSubmitted;

  onSubmittedField(ValueType value) {
    onSubmitted?.call(value);
    if (state.formController?.saveUsingEnterKey == true) {
      state.formController?.save();
    }
  }

  /// Builder for the input field.
  /// This is called when the input field is built.
  /// The builder should return a widget that represents the input field.
  /// The builder is called with a [InputState] object.
  /// This object can be used to get the current value of the input field,
  /// and to update the value of the input field.
  Widget fieldBuilder(
    BuildContext context,
    WidgetRef ref, {
    required InputState<ValueType> state,
    required FocusNode focusNode,
  }) {
    return const LimitedBox(
      maxWidth: 0,
      maxHeight: 0,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useListenable(state);
    useListenable(state.focusNode);

    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final color = fillColor ?? colors.surface;
    final foregroundColor = color.foreground;

    final errorMessage = errorBuilder?.call(context, state.errorCode);
    final error = AnimatedHider(
      visible: state.interacted && !state.valid && state.hasBeenValid,
      child: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: Text(
          textAlign: alignment == InputFieldAlignment.start ||
                  alignment == InputFieldAlignment.center
              ? TextAlign.start
              : TextAlign.end,
          errorMessage ?? "",
          style: text.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.error,
            height: 1,
          ),
        ),
      ),
    );

    final field = Column(
      crossAxisAlignment: alignment == InputFieldAlignment.start ||
              alignment == InputFieldAlignment.center
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        fieldBuilder(
          context,
          ref,
          state: state,
          focusNode: state.focusNode,
        ),
        error,
      ],
    );

    return Focus(
      canRequestFocus: false,
      onFocusChange: (hasFocus) {
        if (hasFocus) state.focusNode.requestFocus();
      },
      child: dense
          ? fieldBuilder(
              context,
              ref,
              state: state,
              focusNode: state.focusNode,
            )
          : GestureDetector(
              onTap: () => enabled ? state.focusNode.requestFocus() : null,
              child: Glass(
                state: GlassState.translucent,
                color: color,
                transparency: 0.9,
                cornerRadius: BorderRadius.circular(12),
                borderWidth: 2,
                borderColor: state.focusNode.hasFocus && focusHighlight
                    ? colors.primary
                    : Colors.transparent,
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (alignment == InputFieldAlignment.start)
                          Flexible(
                            fit: FlexFit.loose,
                            child: field,
                          ),
                        if (leading != null)
                          Padding(
                            padding: EdgeInsets.only(
                              right: (padding.left * 0.7).clamp(4, 28),
                            ),
                            child: leading is IconData
                                ? Icon(
                                    icon: leading,
                                    color: foregroundColor,
                                  )
                                : leading,
                          ),
                        alignment == InputFieldAlignment.center
                            ? Flexible(
                                fit: FlexFit.loose,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (label != null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 6.0),
                                        child: Text(
                                          label!,
                                          style: text.labelMedium?.copyWith(
                                            color: foregroundColor
                                                .withOpacity(0.7),
                                            height: 1,
                                          ),
                                        ),
                                      ),
                                    field
                                  ],
                                ),
                              )
                            : Text(
                                label ?? "",
                                style: text.bodyLarge?.copyWith(
                                  color: foregroundColor,
                                  height: 1,
                                ),
                              ),
                        if (labelTrailing != null)
                          Padding(
                            padding: EdgeInsets.only(
                              left: (padding.left * 0.7).clamp(4, 28),
                            ),
                            child: labelTrailing is IconData
                                ? Icon(
                                    icon: labelTrailing,
                                    color: foregroundColor,
                                  )
                                : labelTrailing,
                          ),
                        if (alignment == InputFieldAlignment.end)
                          Flexible(
                            child: field,
                          ),
                        if (alignment == InputFieldAlignment.end &&
                            trailing != null)
                          const SizedBox(
                            width: 12,
                          ),
                        if (trailing != null)
                          trailing is IconData
                              ? Icon(
                                  icon: trailing as IconData,
                                  color: foregroundColor,
                                )
                              : trailing!,
                      ],
                    ),
                    if (footer != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 4),
                        child: footer!,
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
