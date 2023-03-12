import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:zero_flutter/zero_flutter.dart';

class DecimalFormatter extends TextInputFormatter {
  DecimalFormatter({
    this.currencySymbol,
    this.separator = '.',
    this.thousandsSeparator = ',',
    this.decimalPlaces = 2,
  });

  final String separator;
  final String thousandsSeparator;
  final String? currencySymbol;
  final int decimalPlaces;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String value = newValue.text;

    // Remove all non-numeric characters except the separator
    value = value.replaceAll(RegExp('[^0-9$separator]'), '');

    // Remove all leading zeros
    value = value.replaceAll(RegExp('^0+'), '');

    // Add a leading zero if the value is a decimal and the first character is a separator
    if (value.contains(separator) && value.startsWith(separator)) {
      value = '0$value';
    }

    // Add a leading zero if the value is a decimal and the first character is a separator
    if (value.contains(separator) && value.startsWith(separator)) {
      value = '0$value';
    }

    // Add missing group separators
    final parts = value.split(separator);
    parts[0] = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}$thousandsSeparator',
    );

    // limit the number of decimal places
    if (parts.length > 1) {
      parts[1] = parts[1].substring(
        0,
        parts[1].length.clamp(0, decimalPlaces),
      );
    }

    // Add the separator back in
    value = parts.join(separator);

    if (currencySymbol != null) {
      value = '$currencySymbol $value';
    }

    // keep the cursor in the same place
    // if the new value is longer move the cursorf
    // the difference between the old and new length
    final cursorOffset =
        (value.length - oldValue.text.length).clamp(0, value.length);
    final cursorPosition = (oldValue.selection.baseOffset + cursorOffset)
        .clamp(currencySymbol != null ? 2 : 0, value.length);

    return TextEditingValue(
      text: value,
      selection: TextSelection(
        baseOffset: cursorPosition,
        extentOffset: cursorPosition,
      ),
    );
  }
}

class NumericInput extends InputField<num> {
  const NumericInput(
    super.state, {
    super.key,

    // InputField specific
    super.errorBuilder,
    super.alignment = InputFieldAlignment.end,
    super.dense = false,
    super.padding = const EdgeInsets.symmetric(
      vertical: 14,
      horizontal: 20,
    ),
    super.fillColor,
    super.leading,
    super.trailing,
    super.enabled = true,
    super.label,
    super.onSubmitted,

    // NumericInput specific
    this.stepAmount = 1,
    this.min = 0,
    this.max = double.infinity,
    this.currency = false,
    this.currencySymbol = '\$',
  });

  final num? stepAmount;
  final num? min;
  final num? max;

  final bool currency;
  final String currencySymbol;

  NumberFormat formatter(Locale locale) {
    if (currency) {
      final groupSeparator = NumberFormat.decimalPattern().symbols.GROUP_SEP;
      final decimalSeparator =
          NumberFormat.decimalPattern().symbols.DECIMAL_SEP;
      return NumberFormat.currency(
        locale: locale.toString(),
        symbol: currencySymbol,
        customPattern:
            '$currencySymbol #$groupSeparator##0${decimalSeparator}00',
        decimalDigits: 2,
      );
    } else {
      return NumberFormat.decimalPattern();
    }
  }

  @override
  Widget fieldBuilder(
    BuildContext context,
    WidgetRef ref, {
    required InputState<num> state,
    required FocusNode focusNode,
  }) {
    final locale = ref.watch(currentLocaleProvider);
    final colors = Theme.of(context).colorScheme;
    final textController = useTextEditingController();

    final numberFormatter = formatter(locale);

    num numberFromString(String value) {
      try {
        return numberFormatter.parse(value);
      } catch (e) {
        return state.value;
      }
    }

    useEffect(
      () {
        final previousSelection = textController.selection;
        final previousText = textController.text;
        textController.text = numberFormatter.format(
          state.value / (currency ? 100 : 1),
        );
        final difference = textController.text.length - previousText.length;
        final cursorPosition =
            (previousSelection.baseOffset + difference).clamp(
          0,
          textController.text.length,
        );
        textController.selection = TextSelection(
          baseOffset: cursorPosition,
          extentOffset: cursorPosition,
        );
        return null;
      },
      [state.value],
    );

    return Row(
      children: [
        if (alignment == InputFieldAlignment.end) const Spacer(),
        AnimatedGlass(
          state: GlassState.opaque,
          color: colors.background,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          cornerRadius: BorderRadius.circular(22),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                config: IconButton.defaultConfig.copyWith(
                  size: ButtonSize.small,
                  fillColor: colors.background,
                ),
                icon: Icons.remove,
                onPressed: enabled
                    ? () {
                        state.value =
                            (state.value - stepAmount!).clamp(min!, max!);
                      }
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: LimitedBox(
                  maxWidth: 100,
                  child: IntrinsicWidth(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 22,
                      ),
                      child: Focus(
                        canRequestFocus: false,
                        onFocusChange: (hasFocus) {
                          if (!hasFocus && textController.text.isEmpty) {
                            state.value = 0;
                          } else if (!hasFocus) {
                            state.value = state.value;
                          } else if (hasFocus) {
                            textController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: textController.text.length,
                            );
                          }
                        },
                        child: TextField(
                          focusNode: focusNode,
                          controller: textController,
                          enabled: enabled,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration.collapsed(
                            hintText: null,
                            border: InputBorder.none,
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(height: 1),
                          // only allow numbers and decimal point
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            // only allow numbers and decimal points (both dots and commas)
                            // also allow digital grouping separators
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9.,]'),
                            ),
                            DecimalFormatter(
                              currencySymbol: currency ? currencySymbol : null,
                              separator: numberFormatter.symbols.DECIMAL_SEP,
                              thousandsSeparator:
                                  numberFormatter.symbols.GROUP_SEP,
                            ),
                          ],
                          onSubmitted: (value) => onSubmittedField(
                            numberFromString(value),
                          ),
                          onChanged: (value) {
                            final number = numberFromString(value);
                            state.silentValueUpdate(
                              number * (currency ? 100 : 1),
                            );
                          },
                        ),
                      ),
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
                onPressed: enabled
                    ? () {
                        state.value =
                            (state.value + stepAmount!).clamp(min!, max!);
                      }
                    : null,
              )
            ],
          ),
        ),
      ],
    );
  }
}
