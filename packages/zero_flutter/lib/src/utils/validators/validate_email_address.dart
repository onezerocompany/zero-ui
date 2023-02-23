/// Allowed characters in an email address.
/// letters, digits, dashes, underscores, periods, and plus signs are allowed.
/// special characters !#$%&'*+-/=?^_`{|}~ are allowed as well.
final emailAddressCharacters = RegExp(
  r"[a-zA-Z0-9\@\-\.\_\+\!\#\$\%\&\'\*\+\-\/\=\?\^\_\`\{\|\}\~]",
);

final emailAddressRegex = RegExp(
  r"^[a-zA-Z0-9\@\-\.\_\+\!\#\$\%\&\'\*\+\-\/\=\?\^\_\`\{\|\}\~]+$",
);

/// Function that validates an email address.
///
/// The email address can only contain letters, digits, dashes, underscores, periods, and plus signs.
///
/// The email address must contain an '@' symbol.
/// It must contain at least one period after the '@' symbol.
/// ‘@’ and ‘.’ cannot be the last character.
/// and cannot be next to each other.
bool validateEmailAddress(String emailAddress) {
  if (!emailAddressRegex.hasMatch(emailAddress)) {
    return false;
  }
  if (!emailAddress.contains('@')) {
    return false;
  }
  if (!emailAddress.contains('.')) {
    return false;
  }
  if (emailAddress.endsWith('@') || emailAddress.endsWith('.')) {
    return false;
  }
  if (emailAddress.contains('@.')) {
    return false;
  }
  if (emailAddress.contains('..')) {
    return false;
  }
  // make sure there is a period after the @ symbol
  if (emailAddress.indexOf('@') > emailAddress.lastIndexOf('.')) {
    return false;
  }
  return true;
}
