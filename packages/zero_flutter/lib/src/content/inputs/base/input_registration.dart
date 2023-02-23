import 'package:zero_flutter/zero_flutter.dart';

class InputFieldRegistration<ValueType> extends ChangeNotifier {
  InputFieldRegistration({
    required this.input,
    required this.state,
    required this.focusNode,
  });

  final InputField<ValueType> input;
  final FocusNode focusNode;
  InputState<ValueType> state;

  /// Updates the value of the input field with the given [id].
  /// If the input field with the given [id] is not found, nothing happens.
  updateValue(
    ValueType value, {
    bool sanitize = true,
    bool forStoring = false,
    bool markInteracted = false,
    bool markHasBeenValid = false,
  }) {
    ValueType sanitizedValue = value;
    if (sanitize && value != null && input.sanitizer != null) {
      sanitizedValue = input.sanitizer?.call(value, forStoring) ?? value;
    }

    String? errorCode;
    if (input.validator != null) {
      errorCode = input.validator?.call(sanitizedValue);
    }

    updateState(
      InputState(
        storedValue: state.storedValue,
        value: sanitizedValue,
        dirty: sanitizedValue != state.storedValue,
        errorCode: errorCode,
        interacted: markInteracted ? true : state.interacted,
        hasBeenValid:
            state.hasBeenValid || errorCode == null || markHasBeenValid,
      ),
    );
  }

  void updateState(InputState<ValueType> state) {
    this.state = state;
    notifyListeners();
  }

  reset() {
    updateValue(state.storedValue, sanitize: false);
  }
}
