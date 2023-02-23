class InputState<ValueType> {
  const InputState({
    required this.storedValue,
    required this.value,
    this.dirty = false,
    this.errorCode,
    this.interacted = false,
    this.hasBeenValid = false,
  });

  /// The stored value of the input field.
  final ValueType storedValue;

  /// The current value of the input field.
  final ValueType value;

  /// Whether the input field is valid.
  /// This is `true` if the input field is valid.
  /// This is `false` if the input field is invalid.
  bool get valid => errorCode == null;

  /// Whether the input field is dirty.
  final bool dirty;

  /// Current error code of the input field.
  /// This is `null` if the input field is valid.
  final String? errorCode;

  /// Whether the user has interacted with the input field.
  /// This is `true` if the user has interacted with the input field.
  /// This is `false` if the user has not interacted with the input field.
  final bool interacted;

  /// Whether a save has been attempted.
  final bool hasBeenValid;

  /// Creates the hash code for this object.
  @override
  int get hashCode =>
      value.hashCode ^
      dirty.hashCode ^
      errorCode.hashCode ^
      storedValue.hashCode;

  /// compares two [InputState] objects.
  /// This is used to determine whether the input field needs to be rebuilt.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InputState<ValueType> &&
        other.value == value &&
        other.dirty == dirty &&
        other.errorCode == errorCode &&
        other.storedValue == storedValue;
  }

  @override
  String toString() {
    return 'InputFieldState(value: $value, dirty: $dirty, errorCode: $errorCode)';
  }
}
