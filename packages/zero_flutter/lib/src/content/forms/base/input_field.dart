import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zero_flutter/zero_flutter.dart';

export 'input_state.dart';
export 'input_form.dart';

export '../check_input.dart';
export '../date_time_input.dart';
export '../list_input.dart';
export '../numeric_input.dart';
export '../options_input.dart';
export '../switch_input.dart';
export '../text_input.dart';

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
    this.leading,
    this.trailing,
    this.enabled = true,
    this.alignment = InputFieldAlignment.center,
    this.fillColor,
    this.dense = false,
    this.padding = EdgeInsets.zero,
    this.onSubmitted,
    this.errorBuilder,
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

  /// Called when the input field is submitted.
  /// e.g. when the user presses the enter key.
  final Function(ValueType value)? onSubmitted;

  onSubmittedField(ValueType value) {
    onSubmitted?.call(value);
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

    final focus = useFocusNode();
    useListenable(focus);

    final text = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;
    final color = fillColor ??
        (isDark ? colors.background.withBrightness(1.5) : colors.surface);
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

    final field = Flexible(
      child: Column(
        crossAxisAlignment: alignment == InputFieldAlignment.start ||
                alignment == InputFieldAlignment.center
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          fieldBuilder(
            context,
            ref,
            state: state,
            focusNode: focus,
          ),
          error,
        ],
      ),
    );

    return Focus(
      canRequestFocus: false,
      onFocusChange: (hasFocus) {
        if (hasFocus) focus.requestFocus();
      },
      child: GestureDetector(
        onTap: () => focus.requestFocus(),
        child: AnimatedGlass(
          state: dense ? GlassState.invisible : GlassState.translucent,
          color: color,
          transparency: 0.9,
          cornerRadius: BorderRadius.circular(12),
          borderWidth: 2,
          borderColor: focus.hasFocus ? colors.primary : Colors.transparent,
          padding: dense ? EdgeInsets.zero : padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (alignment == InputFieldAlignment.start) field,
                  if (leading != null)
                    Padding(
                      padding: EdgeInsets.only(
                        right: padding.left * 0.6,
                      ),
                      child: leading is IconData
                          ? Icon(
                              icon: leading,
                              color: foregroundColor,
                            )
                          : leading,
                    ),
                  alignment == InputFieldAlignment.center
                      ? Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (label != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 6.0),
                                  child: Text(
                                    label!,
                                    style: text.labelMedium?.copyWith(
                                      color: foregroundColor.withOpacity(0.7),
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
                  if (trailing != null)
                    trailing is IconData
                        ? Icon(
                            icon: trailing as IconData,
                            color: foregroundColor,
                          )
                        : trailing!,
                  if (alignment == InputFieldAlignment.end)
                    const SizedBox(
                      width: 12,
                    ),
                  if (alignment == InputFieldAlignment.end) field,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}