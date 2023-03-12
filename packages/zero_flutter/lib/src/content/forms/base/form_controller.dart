import 'package:zero_flutter/zero_flutter.dart';

class FormController extends ChangeNotifier {
  FormController({
    this.onSaved,
  });

  /// Callback when the form is saved.
  final Function(
    Map<String, dynamic> values,
    VoidCallback saved,
  )? onSaved;

  /// The input fields of the form.
  final Map<String, InputState> inputs = {};

  /// Register an input field.
  void register<InputType>(InputState<InputType> input) {
    inputs[input.id] = input;
    input.addListener(notifyListeners);
  }

  /// Unregister an input field.
  void unregister<InputType>(InputState<InputType> input) {
    input.removeListener(notifyListeners);
    inputs.remove(input.id);
  }

  /// Values of all input fields.
  /// This is a map of input field id to input field value.
  Map<String, dynamic> get values {
    final output = <String, dynamic>{};
    for (final input in inputs.values) {
      output[input.id] = input.value;
    }
    return output;
  }

  /// Whether the form was ever valid.
  bool get hasBeenValid => inputs.values.every((input) => input.hasBeenValid);

  /// Whether the form is valid.
  bool get valid => inputs.values.every((input) => input.valid);

  /// Whether the form is dirty.
  bool get dirty => inputs.values.any((input) => input.dirty);

  /// Whether the form can be saved.
  bool get canSave => (valid || !hasBeenValid) && dirty;

  /// Save the form.
  void save() {
    for (final input in inputs.values) {
      input.sanitize(forStoring: true);
    }

    if (!valid) return;
    onSaved?.call(values, () {
      for (final input in inputs.values) {
        input.save();
      }
    });
  }

  /// Resets all the input fields.
  void reset() {
    for (final input in inputs.values) {
      input.reset();
    }
  }

  @override
  String toString() {
    return 'FormController{inputs: ${inputs.length}, valid: $valid, dirty: $dirty, canSave: $canSave}';
  }
}
