import 'package:flutter_test/flutter_test.dart';
import 'package:zero_flutter/src/utils/validators/validate_email_address.dart';

void main() {
  test('Valid email address returns true', () {
    expect(validateEmailAddress('test.email+label@example.com'), isTrue);
  });

  test('Email address without "@" symbol returns false', () {
    expect(validateEmailAddress('test.example.com'), isFalse);
  });

  test('Email address without a period after "@" symbol returns false', () {
    expect(validateEmailAddress('test@example'), isFalse);
  });

  test('Email address ending with "@" returns false', () {
    expect(validateEmailAddress('test@'), isFalse);
  });

  test('Email address ending with "." returns false', () {
    expect(validateEmailAddress('test.email@example.com.'), isFalse);
  });

  test('Email address containing "@." returns false', () {
    expect(validateEmailAddress('test@.com'), isFalse);
  });

  test('Email address containing an invalid character returns false', () {
    expect(validateEmailAddress('test&email@example.com'), isFalse);
  });

  test('Empty email address returns false', () {
    expect(validateEmailAddress(''), isFalse);
  });
}
