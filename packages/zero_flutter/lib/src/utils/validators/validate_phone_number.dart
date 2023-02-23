/// Allowed characters in a phone number.
/// numbers, spaces, dashes, plus and parentheses are allowed.
/// For example, +1 (234) 567-890
/// This is used to filter out characters that are not allowed.
/// The phone number is validated further in [validatePhoneNumber].
final phoneNumberCharacters = RegExp(r'[0-9\-\+\(\)\s]');
final phoneNumberRegex = RegExp(r'^[0-9\-\+\(\)\s]+$');

/// Function that validates a phone number.
///
/// If the phone number should be international, set [mustBeInternational] to true.
/// then the phone number must start with a '+'.
///
/// The phone number can only contain digits, spaces, dashes, and parentheses.
///
///
/// The phone number must be at least 4 digits long.
/// The phone number must be at most 15 digits long.
///
/// Returns true if the phone number is valid, false otherwise.
bool validatePhoneNumber(
  String phoneNumber, {
  bool mustBeInternational = false,
}) {
  if (phoneNumber.isEmpty) return false;
  if (!phoneNumberRegex.hasMatch(phoneNumber)) return false;

  final phoneNumberDigits = phoneNumber.replaceAll(RegExp(r'\D'), '');
  if (phoneNumberDigits.length < 4) return false;
  if (phoneNumberDigits.length > 15) return false;

  // if must be international, then the phone number must start with a + or (+.
  if (mustBeInternational &&
      (!phoneNumber.startsWith('+') || !phoneNumber.startsWith('(+'))) {
    return false;
  }

  // cannot allow double plus
  if (phoneNumber.contains('++')) return false;

  return true;
}
