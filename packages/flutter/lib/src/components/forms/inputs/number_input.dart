import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:zero_ui/zero_ui.dart';

class DecimalFormatter extends TextInputFormatter {
  DecimalFormatter({
    this.currencySymbol,
    this.separator = '.',
    this.thousandsSeparator = ',',
    this.decimalPlaces = 2,
    this.separateThousands = false,
  });

  final String separator;
  final String thousandsSeparator;
  final String? currencySymbol;
  final int decimalPlaces;
  final bool separateThousands;

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
    if (separateThousands) {
      parts[0] = parts[0].replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]}$thousandsSeparator',
      );
    }

    // limit the number of decimal places
    if (parts.length > 1) {
      parts[1] = parts[1].substring(
        0,
        parts[1].length.clamp(0, decimalPlaces),
      );
    }

    // Remove the separator if there are no decimal places
    if (decimalPlaces == 0) {
      value = value.replaceAll(separator, '');
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

class NumberInput<NumberType extends num> extends InputField<NumberType> {
  const NumberInput(
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
    super.labelTrailing,
    super.trailing,
    super.enabled = true,
    super.label,
    super.onSubmitted,
    super.footer,

    // NumericInput specific

    this.stepAmount,
    this.min,
    this.max,
    this.currency = false,
    this.currencySymbol = '\$',
    this.decimalPlaces = 2,
    this.unitLabel,
  });

  final NumberType? stepAmount;
  final NumberType? min;
  final NumberType? max;

  final bool currency;
  final String currencySymbol;
  final int decimalPlaces;
  final String? unitLabel;

  NumberFormat formatter(Locale locale, {bool separateThousands = false}) {
    if (currency) {
      final groupSeparator = NumberFormat.decimalPattern().symbols.GROUP_SEP;
      final decimalSeparator =
          NumberFormat.decimalPattern().symbols.DECIMAL_SEP;
      return NumberFormat.currency(
        locale: locale.toString(),
        symbol: currencySymbol,
        customPattern: separateThousands
            ? '$currencySymbol #$groupSeparator##0${decimalSeparator}00'
            : '$currencySymbol #0${decimalSeparator}00',
        decimalDigits: decimalPlaces,
      );
    } else {
      final decimalPlacesPattern = decimalPlaces == 0
          ? ""
          : ".${List.generate(decimalPlaces, (index) => '#').join()}";
      return NumberFormat(
        separateThousands
            ? '#,###$decimalPlacesPattern'
            : '#$decimalPlacesPattern',
        locale.toString(),
      );
    }
  }

  @override
  Widget fieldBuilder(
    BuildContext context,
    WidgetRef ref, {
    required InputState<NumberType> state,
    required FocusNode focusNode,
  }) {
    final locale = ref.watch(currentLocaleProvider);
    final colors = Theme.of(context).colorScheme;
    final textController = useTextEditingController();

    final numberFormatter = formatter(locale);

    NumberType numberFromString(String value, {num multiplier = 1}) {
      try {
        final parsed = numberFormatter.parse(value) * multiplier;
        if (NumberType == int) {
          return parsed.toInt() as NumberType;
        } else if (NumberType == double) {
          return parsed.toDouble() as NumberType;
        } else {
          return parsed as NumberType;
        }
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
        Column(
          children: [
            if (unitLabel != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  unitLabel!,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colors.onBackground.withOpacity(0.6),
                        height: 1,
                      ),
                ),
              ),
            Glass(
              state: GlassState.opaque,
              color: colors.background,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              cornerRadius: BorderRadius.circular(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                    child: IconButton(
                      config: IconButton.defaultConfig.copyWith(
                        size: ButtonSize.small,
                        fillColor: colors.background,
                        transparency: 0.9,
                      ),
                      enabled: enabled,
                      icon: Icons.remove,
                      onPressed: enabled
                          ? () {
                              final clamped = (state.value - (stepAmount ?? 1))
                                  .clamp(min ?? 0, max ?? double.infinity);
                              if (NumberType == int) {
                                state.value = clamped.toInt() as NumberType;
                              } else if (NumberType == double) {
                                state.value = clamped.toDouble() as NumberType;
                              } else {
                                state.value = clamped as NumberType;
                              }
                            }
                          : null,
                    ),
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
                                state.value = 0 as NumberType;
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
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: decimalPlaces > 0,
                              ),
                              inputFormatters: [
                                // only allow numbers and decimal points (both dots and commas)
                                // also allow digital grouping separators
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.,]'),
                                ),
                                DecimalFormatter(
                                  currencySymbol:
                                      currency ? currencySymbol : null,
                                  separator:
                                      numberFormatter.symbols.DECIMAL_SEP,
                                  thousandsSeparator:
                                      numberFormatter.symbols.GROUP_SEP,
                                  separateThousands: currency,
                                  decimalPlaces: decimalPlaces,
                                ),
                              ],
                              onSubmitted: (value) {
                                final number = numberFromString(value) *
                                    (currency ? 100 : 1);
                                if (NumberType == int) {
                                  onSubmittedField(
                                    number.toInt() as NumberType,
                                  );
                                } else if (NumberType == double) {
                                  onSubmittedField(
                                    number.toDouble() as NumberType,
                                  );
                                } else {
                                  onSubmittedField(number as NumberType);
                                }
                              },
                              onChanged: (value) {
                                final number = numberFromString(
                                  value,
                                  multiplier: currency ? 100 : 1,
                                );
                                if (NumberType is int) {
                                  state.silentValueUpdate(
                                    number.toInt() as NumberType,
                                  );
                                } else if (NumberType is double) {
                                  state.silentValueUpdate(
                                    number.toDouble() as NumberType,
                                  );
                                } else {
                                  state.silentValueUpdate(number);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ClipOval(
                    child: IconButton(
                      config: IconButton.defaultConfig.copyWith(
                        size: ButtonSize.small,
                        fillColor: colors.background,
                        transparency: 0.9,
                      ),
                      enabled: enabled,
                      icon: Icons.add,
                      onPressed: enabled
                          ? () {
                              final clamped = (state.value + (stepAmount ?? 1))
                                  .clamp(min ?? 0, max ?? double.infinity);
                              if (NumberType == int) {
                                state.value = clamped.toInt() as NumberType;
                              } else if (NumberType == double) {
                                state.value = clamped.toDouble() as NumberType;
                              } else {
                                state.value = clamped as NumberType;
                              }
                            }
                          : null,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
