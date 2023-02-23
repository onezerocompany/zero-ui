import 'dart:math';

import 'package:flutter/services.dart';
import 'package:zero_flutter/zero_flutter.dart';

class NumericInput extends InputField<num> {
  const NumericInput(
    BuildContext context, {
    super.key,
    super.controller,

    // InputField specific
    required super.id,
    super.validator,
    super.errorBuilder,
    super.alignment = InputFieldAlignment.end,
    super.dense = false,
    super.padding = const EdgeInsets.all(20),
    super.fillColor,
    super.leading,
    super.trailing,
    super.enabled = true,
    super.label,
    super.sanitizer,
    super.onSubmitted,

    // NumericInput specific
    this.stepAmount = 1,
    this.min = 0,
    this.max = double.infinity,
  });

  final num? stepAmount;
  final num? min;
  final num? max;

  @override
  num defaultValue() {
    return 0;
  }

  @override
  InputFieldState<num, NumericInput> createState() {
    return _NumericInputState();
  }
}

class _NumericInputState extends InputFieldState<num, NumericInput> {
  final _controller = TextEditingController();

  @override
  void stateUpdated(InputState<num> state) {
    super.stateUpdated(state);
    final selection = _controller.selection;
    _controller.text = state.value.toString();
    // make sure the cursor is at the previous position
    _controller.selection = TextSelection.fromPosition(
      TextPosition(
        offset: min(selection.baseOffset, _controller.text.length),
      ),
    );
  }

  @override
  Widget fieldBuilder(
    BuildContext context, {
    required InputState<num> state,
    required FocusNode focusNode,
  }) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.alignment == InputFieldAlignment.end) const Spacer(),
        IconButton(
          config: IconButton.defaultConfig.copyWith(
            size: ButtonSize.small,
            fillColor: colors.background,
          ),
          icon: Icons.remove,
          onPressed: widget.enabled
              ? () {
                  final oldValue = widget
                          .effectiveController(context)
                          ?.getValue<num>(widget.id) ??
                      0;
                  final newValue = (oldValue - (widget.stepAmount ?? 1)).clamp(
                    widget.min ?? double.negativeInfinity,
                    widget.max ?? double.infinity,
                  );
                  widget
                      .effectiveController(context)
                      ?.updateValue(widget.id, newValue);
                }
              : null,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: IntrinsicWidth(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 34,
              ),
              child: TextField(
                focusNode: fieldFocusNode,
                controller: _controller,
                enabled: widget.enabled,
                textAlign: TextAlign.center,
                decoration: const InputDecoration.collapsed(
                  hintText: null,
                  border: InputBorder.none,
                ),
                style: Theme.of(context).textTheme.bodyLarge,
                // only allow numbers and decimal point
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  // only allow numbers and decimal points (both dots and commas)
                  // also allow digital grouping separators
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^[0-9.,]*$'),
                  ),
                ],
                onSubmitted: (value) => onSubmittedField(
                  num.tryParse(value) ?? 0,
                ),
                // clamp value to min/max
                onChanged: (value) {
                  final numValue = num.tryParse(value);
                  if (numValue != null) {
                    if (widget.min != null && numValue < widget.min!) {
                      widget
                          .effectiveController(context)
                          ?.updateValue<num>(widget.id, widget.min!);
                    } else if (widget.max != null && numValue > widget.max!) {
                      widget
                          .effectiveController(context)
                          ?.updateValue<num>(widget.id, widget.max!);
                    } else {
                      widget
                          .effectiveController(context)
                          ?.updateValue<num>(widget.id, numValue);
                    }
                  }
                  widget
                      .effectiveController(context)
                      ?.updateValue<num>(widget.id, numValue!);
                },
              ),
            ),
          ),
        ),
        IconButton(
          config: IconButton.defaultConfig.copyWith(
            size: ButtonSize.small,
            fillColor: colors.background,
          ),
          icon: Icons.add,
          onPressed: widget.enabled
              ? () {
                  final oldValue = widget
                          .effectiveController(context)
                          ?.getValue<num>(widget.id) ??
                      0;
                  final newValue = (oldValue + (widget.stepAmount ?? 1)).clamp(
                    widget.min ?? double.negativeInfinity,
                    widget.max ?? double.infinity,
                  );
                  widget
                      .effectiveController(context)
                      ?.updateValue(widget.id, newValue);
                }
              : null,
        )
      ],
    );
  }
}
