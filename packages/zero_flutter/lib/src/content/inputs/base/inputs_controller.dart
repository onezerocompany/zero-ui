import 'package:zero_flutter/zero_flutter.dart';

/// A controller for input fields that allows for easy access to the current
/// value of the inputs and validation. It also allows for listening to
/// changes in the input fields. A [InputController] can be used with
/// [Input] widgets to listen to changes in the input fields.
class InputsController extends ChangeNotifier {
  InputsController({
    this.storedValues = const <String, dynamic>{},
    this.onSaved,
  });

  /// Currently stored values for the input fields.
  /// These values should reflect the values that are stored in the database.
  ///
  /// These values are mapped to the [InputField] widgets' [InputField.id]s.
  /// This can be empty in case it concerns data that is not yet available.
  final Map<String, dynamic> storedValues;

  /// Inputs that are registered with this controller.
  /// These are the [InputField] widgets that are associated with this controller.
  final List<InputFieldRegistration> _inputs = [];

  /// Returns the registration for a given [InputField.id].
  InputFieldRegistration<ValueType>? _getRegistration<ValueType>(String id) {
    return _inputs.firstWhereOrNull(
      (InputFieldRegistration registration) => registration.input.id == id,
    ) as InputFieldRegistration<ValueType>?;
  }

  /// Updates the value of the input field with the given [id].
  /// If the input field with the given [id] is not found, nothing happens.
  updateValue<ValueType>(String id, ValueType value) {
    final InputFieldRegistration<ValueType>? registration =
        _getRegistration<ValueType>(id);
    if (registration == null) {
      return;
    }
    registration.updateValue(
      value,
      markInteracted: true,
    );
    notifyListeners();
  }

  /// Get value of the input field with the given [id].
  /// If the input field with the given [id] is not found, `null` is returned.
  ValueType? getValue<ValueType>(String id) {
    final InputFieldRegistration<ValueType>? registration =
        _getRegistration<ValueType>(id);
    if (registration == null) {
      return null;
    }
    return registration.state.value;
  }

  /// Get indidiual input field state.
  /// If the input field with the given [id] is not found, `null` is returned.
  InputState<ValueType>? getState<ValueType>(String id) {
    final InputFieldRegistration<ValueType>? registration =
        _getRegistration<ValueType>(id);
    if (registration == null) {
      return null;
    }
    return registration.state;
  }

  /// Creates a map of the values of the input fields.
  /// The map is created by mapping the [InputField] widgets' [InputField.id]s
  /// to their current values.
  final Function(Map<String, dynamic> values)? onSaved;

  /// Registers an input field with this controller.
  /// This is called by the [InputField] widget when it is built.
  InputFieldRegistration<ValueType>? register<ValueType>(
    InputField<ValueType> input,
    FocusNode focusNode,
  ) {
    final InputFieldRegistration<ValueType>? existingRegistration =
        _getRegistration<ValueType>(input.id);

    if (existingRegistration != null) {
      return existingRegistration;
    }

    final registration = InputFieldRegistration<ValueType>(
      input: input,
      focusNode: focusNode,
      state: InputState<ValueType>(
        storedValue: storedValues[input.id] ?? input.defaultValue(),
        value: storedValues[input.id] ?? input.defaultValue(),
      ),
    );

    _inputs.add(registration);

    registration.updateValue(
      storedValues[input.id] ?? input.defaultValue(),
      sanitize: false,
    );

    return registration;
  }

  /// Resets the input fields to their initial values.
  reset() {
    for (final InputFieldRegistration registration in _inputs) {
      registration.reset();
    }
    notifyListeners();
  }

  bool hasSaved = false;

  /// Saves the current values of the input fields.
  /// This is called when the form is submitted.
  bool save() {
    hasSaved = true;
    notifyListeners();
    // mark all inputs as interacted
    // sanitize all inputs for saving
    for (final InputFieldRegistration registration in _inputs) {
      registration.updateValue(
        registration.state.value,
        markInteracted: true,
        forStoring: true,
        markHasBeenValid: true,
      );
    }

    // check if the form is valid
    // otherwise, do not save
    if (!valid) return false;

    final Map<String, dynamic> values = {};
    for (final InputFieldRegistration registration in _inputs) {
      values[registration.input.id] = registration.state.value;
    }
    onSaved?.call(values);

    return true;
  }

  /// Moves to the next invalid input field in the form.
  /// If all input fields are valid, saves the form.
  void nextFieldOrSave() {
    for (final InputFieldRegistration registration in _inputs) {
      if (!registration.state.valid) {
        registration.focusNode.requestFocus();
        return;
      }
    }

    save();
  }

  /// Whether the form is dirty.
  /// A form is dirty when one of the input fields has been changed.
  /// This is used to determine whether the form should be saved.
  bool get dirty {
    for (final InputFieldRegistration registration in _inputs) {
      if (registration.state.dirty) {
        return true;
      }
    }
    return false;
  }

  /// Whether the form is valid.
  /// A form is valid when all of the input fields are valid.
  /// This is used to determine whether the form can be submitted.
  bool get valid {
    if (!hasSaved) return true;
    for (final InputFieldRegistration registration in _inputs) {
      if (registration.state.errorCode != null) {
        return false;
      }
    }
    return true;
  }
}
