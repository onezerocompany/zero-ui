import 'package:zero_ui/zero_ui.dart';

class FormValues {
  const FormValues({
    required this.values,
  });

  final Map<String, dynamic> values;

  ValueType? get<ValueType>(String key) {
    if (!values.containsKey(key)) {
      return null;
    }
    return values[key] as ValueType?;
  }
}

typedef FormSavedCallback = void Function(
  FormValues values,
  VoidCallback saved,
);

class FormController extends ChangeNotifier {
  FormController({
    this.onSaved,
    this.saveUsingEnterKey = true,
  });

  /// Callback when the form is saved.
  final FormSavedCallback? onSaved;

  /// The input fields of the form.
  final Map<String, InputState> inputs = {};

  /// Whether to save using the enter key.
  final bool saveUsingEnterKey;

  /// Register an input field.
  void register<InputType>(InputState<InputType> input) {
    inputs[input.id] = input;
    input.addListener(notifyListeners);
    Future.delayed(Duration.zero, notifyListeners);
  }

  /// Unregister an input field.
  void unregister<InputType>(InputState<InputType> input) {
    input.removeListener(notifyListeners);
    inputs.remove(input.id);
  }

  /// All enabled input fields.
  Iterable<InputState> get enabledInputs =>
      inputs.values.where((input) => !input.disabled);

  /// Values of all input fields.
  /// This is a map of input field id to input field value.
  FormValues get values {
    final output = <String, dynamic>{};
    for (final input in enabledInputs) {
      output[input.id] = input.value;
    }
    return FormValues(values: output);
  }

  /// Whether the form was ever valid.
  bool get hasBeenValid => enabledInputs.every((input) => input.hasBeenValid);

  /// Whether the form is valid.
  bool get valid => enabledInputs.every((input) => input.valid);

  /// Whether the form is dirty.
  bool get dirty => enabledInputs.any((input) => input.dirty);

  /// Whether the form can be saved.
  bool get canSave => (valid || !hasBeenValid) && dirty;

  /// Save the form.
  void save() {
    for (final input in enabledInputs) {
      input.sanitize(forStoring: true);
    }

    if (!valid) {
      // focus the first invalid input
      for (final input in enabledInputs) {
        if (!input.valid) {
          input.focusNode.requestFocus();
          break;
        }
      }
      return;
    }
    onSaved?.call(values, () {
      for (final input in enabledInputs) {
        input.save();
      }
    });
  }

  /// Resets all the input fields.
  void reset() {
    for (final input in enabledInputs) {
      input.reset();
    }
  }

  @override
  String toString() {
    return 'FormController{inputs: ${inputs.length}, valid: $valid, dirty: $dirty, canSave: $canSave}';
  }
}
