import 'package:zero_flutter/zero_flutter.dart';

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
///
/// It stores its value in an [InputsController] object.
/// When that is changed, the input field will update its value.
/// When the input field is changed, the [InputsController] will be updated.
abstract class InputField<ValueType> extends StatefulWidget {
  const InputField({
    super.key,
    // value related
    this.controller,
    required this.id,
    this.validator,
    this.sanitizer,
    this.errorBuilder,
    // widget related
    this.label,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.alignment = InputFieldAlignment.center,
    this.fillColor,
    this.dense = false,
    this.padding = const EdgeInsets.all(16),
  });

  /// Optional [InputsController] for this input field.
  /// If this is `null`, the input field will use the [InputsController] from
  /// the [InputsForm] widget.
  final InputsController? controller;

  /// Identifier for this input field.
  /// This is used to identify the input field in the [InputsController].
  /// It's also used to create the restoration ID for the input field.
  /// If this is `null`, the input field will not be restored.
  final String id;

  /// Default value for the input field.
  /// This is used when there is no stored value in the [InputsController].
  ValueType defaultValue();

  /// Validator for the input field.
  /// This is called when the input field is changed.
  /// If the validator returns `null`, the input field is valid.
  /// If the validator returns a code, the input field is invalid.
  final String? Function(ValueType value)? validator;

  /// Sanitizes the input value.
  /// This is called when the input field is changed.
  /// If the sanitizer returns `null`, the input field is not changed.
  /// If the sanitizer returns a value, the input field is changed to that value.
  /// This is useful for sanitizing input values.
  /// For example, if you want to make sure that the input value is always
  /// a multiple of 10, you can use this to round the value to the nearest
  /// multiple of 10.
  final ValueType Function(ValueType value, bool forStoring)? sanitizer;

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

  InputsController? effectiveController(BuildContext context) {
    return controller ?? InputsForm.controller(context);
  }
}

abstract class InputFieldState<ValueType,
    InputWidget extends InputField<ValueType>> extends State<InputWidget> {
  final fieldFocusNode = FocusNode();

  /// The current state of the input field.
  late InputState<ValueType> _inputFieldState = InputState<ValueType>(
    storedValue: widget.defaultValue(),
    value: widget.defaultValue(),
    dirty: false,
    errorCode: null,
  );

  void stateUpdated(InputState<ValueType> state) {
    setState(() {
      _inputFieldState = state;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final registration =
        widget.effectiveController(context)?.register<ValueType>(widget);

    if (registration != null) {
      setState(() {
        _inputFieldState = registration.state;
      });
      stateUpdated(registration.state);
      registration.addListener(() {
        stateUpdated(registration.state);
      });
    }
  }

  /// Builder for the input field.
  /// This is called when the input field is built.
  /// The builder should return a widget that represents the input field.
  /// The builder is called with a [InputState] object.
  /// This object can be used to get the current value of the input field,
  /// and to update the value of the input field.
  Widget fieldBuilder(
    BuildContext context, {
    required InputState<ValueType> state,
    required FocusNode focusNode,
  }) {
    return const LimitedBox(
      maxWidth: 0,
      maxHeight: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;
    final color = widget.fillColor ??
        (isDark ? colors.background.withBrightness(1.5) : colors.surface);
    final foregroundColor = color.foreground;

    final errorMessage =
        widget.errorBuilder?.call(context, _inputFieldState.errorCode);
    final error = AnimatedHider(
      visible: _inputFieldState.errorCode != null &&
          _inputFieldState.interacted &&
          errorMessage != null &&
          _inputFieldState.hasBeenValid,
      child: SizedBox(
        width: double.infinity,
        child: Text(
          textAlign: widget.alignment == InputFieldAlignment.start ||
                  widget.alignment == InputFieldAlignment.center
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
        crossAxisAlignment: widget.alignment == InputFieldAlignment.start ||
                widget.alignment == InputFieldAlignment.center
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          fieldBuilder(
            context,
            state: _inputFieldState,
            focusNode: fieldFocusNode,
          ),
          const SizedBox(
            height: 4,
          ),
          error,
        ],
      ),
    );

    return Focus(
      canRequestFocus: false,
      onFocusChange: (focus) {
        setState(() {});
      },
      child: GestureDetector(
        onTap: () => fieldFocusNode.requestFocus(),
        child: AnimatedGlass(
          state: widget.dense ? GlassState.invisible : GlassState.translucent,
          color: color,
          transparency: 0.9,
          cornerRadius: AdaptiveValue.fixed(
            BorderRadius.circular(12),
          ),
          borderWidth: 2,
          borderColor:
              fieldFocusNode.hasFocus ? colors.primary : Colors.transparent,
          padding: widget.dense ? EdgeInsets.zero : widget.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.alignment == InputFieldAlignment.start) field,
                  if (widget.leading != null)
                    Padding(
                      padding: EdgeInsets.only(
                        right: widget.padding.left * 0.6,
                      ),
                      child: widget.leading is IconData
                          ? Icon(
                              icon: widget.leading,
                              color: foregroundColor,
                            )
                          : widget.leading,
                    ),
                  widget.alignment == InputFieldAlignment.center
                      ? Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.label != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 6.0),
                                  child: Text(
                                    widget.label!,
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
                          widget.label ?? "",
                          style: text.bodyLarge?.copyWith(
                            color: foregroundColor,
                            height: 1,
                          ),
                        ),
                  if (widget.trailing != null)
                    widget.trailing is IconData
                        ? Icon(
                            icon: widget.trailing as IconData,
                            color: foregroundColor,
                          )
                        : widget.trailing!,
                  if (widget.alignment == InputFieldAlignment.end)
                    const SizedBox(
                      width: 12,
                    ),
                  if (widget.alignment == InputFieldAlignment.end) field,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
