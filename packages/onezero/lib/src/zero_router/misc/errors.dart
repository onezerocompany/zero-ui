/// Thrown when [ZeroRouter] is used incorrectly.
class ZeroError extends Error {
  /// Constructs a [ZeroError]
  ZeroError(this.message);

  /// The error message.
  final String message;

  @override
  String toString() => 'ZeroError: $message';
}

/// Thrown when [ZeroRouter] can not handle a user request.
class ZeroException implements Exception {
  /// Creates an exception with message describing the reason.
  ZeroException(this.message);

  /// The reason that causes this exception.
  final String message;

  @override
  String toString() => 'ZeroException: $message';
}
