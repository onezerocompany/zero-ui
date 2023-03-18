import 'package:flutter/foundation.dart';
import 'package:zero_flutter/zero_flutter.dart';

typedef InputStateValidator<ValueType> = String? Function(ValueType? value);
typedef InputStateSanitizer<ValueType> = ValueType? Function(
  ValueType? value, {
  bool forStoring,
});

class InputState<ValueType> extends ChangeNotifier {
  InputState({
    required this.id,
    required this.defaultValue,
    this.formController,
    ValueType? storedValue,
    this.validator,
    this.sanitizer,
    this.autosave = false,
  })  : _value = storedValue ?? defaultValue,
        _storedValue = storedValue {
    formController?.register(this);
  }

  /// Optional form controller of the input field.
  final FormController? formController;

  /// Identifier of the input field.
  final String id;

  /// Focus node of the input field.
  final FocusNode focusNode = FocusNode();

  // Default value of the input field.
  // This is used when the stored value is `null`.
  final ValueType defaultValue;

  @override
  void dispose() {
    formController?.unregister(this);
    super.dispose();
  }

  /// The current value of the input field.
  ValueType _value;
  ValueType get value => _value;
  set value(ValueType newValue) {
    final sanitizedValue = sanitizer?.call(newValue) ?? newValue;
    interacted = true;
    final didUpdate = (sanitizedValue is List && _value is List)
        ? !listEquals(_value as List, sanitizedValue)
        : _value != sanitizedValue;
    _value = sanitizedValue;
    if (autosave && didUpdate && formController?.save != null) {
      formController!.save();
    } else {
      notifyListeners();
    }
  }

  void silentValueUpdate(ValueType newValue) {
    _value = newValue;
  }

  /// The stored value of the input field.
  ValueType? _storedValue;
  ValueType? get storedValue => _storedValue;
  set storedValue(ValueType? newValue) {
    _storedValue = newValue;
    notifyListeners();
  }

  /// Validator of the input field.
  final InputStateValidator<ValueType>? validator;

  /// Sanitizer of the input field.
  final InputStateSanitizer<ValueType>? sanitizer;

  /// Autosave of the input field.
  final bool autosave;

  /// Current error code of the input field.
  /// This is `null` if the input field is valid.
  String? get errorCode => validator?.call(_value);

  /// Whether the input field is valid.
  /// This is `true` if the input field is valid.
  /// This is `false` if the input field is invalid.
  bool get valid {
    final valid = errorCode == null;
    if (valid) hasBeenValid = true;
    return valid;
  }

  /// Whether the input field is dirty.
  /// Uses deep comparison to check if the value has changed.
  bool get dirty => _value is List
      ? !listEquals(_value as List?, _storedValue as List?)
      : _value != _storedValue;

  /// Whether the input field can be saved.
  bool get canSave => (valid || !hasBeenValid) && dirty;

  /// Whether the input field has been interacted with.
  bool interacted = false;

  /// Whether a save has been attempted.
  bool hasBeenValid = false;

  /// Sanitize the given [value].
  void sanitize({bool forStoring = false}) {
    interacted = true;
    hasBeenValid = true;
    value = sanitizer?.call(_value, forStoring: forStoring) ?? _value;
  }

  /// Resets the value of the input field to the stored value.
  void reset() {
    value = storedValue ?? defaultValue;
  }

  /// Saves the value of the input field.
  /// This sets the stored value to the current value.
  void save() {
    storedValue = _value;
  }

  @override
  String toString() {
    // output all the properties of the object
    return 'InputState<$ValueType> {'
        'id: $id, '
        'defaultValue: $defaultValue, '
        'value: $value, '
        'storedValue: $storedValue, '
        'errorCode: $errorCode, '
        'valid: $valid, '
        'dirty: $dirty, '
        'canSave: $canSave, '
        'interacted: $interacted, '
        'hasBeenValid: $hasBeenValid, '
        'validator: $validator, '
        'sanitizer: $sanitizer'
        '}';
  }
}
