import 'package:zero_ui/src/utils/validators/validate_phone_number.dart';
import 'package:test/test.dart';

void main() {
  group('phone number validation', () {
    test("valid phone number", () {
      expect(validatePhoneNumber("1234567890"), true);
    });
    test("invalid phone number", () {
      expect(validatePhoneNumber("123.456789"), false);
    });
    test("international phone number must start with either + or (+", () {
      expect(validatePhoneNumber("+1234567890"), true);
      expect(validatePhoneNumber("(+1234567890"), true);
      expect(
        validatePhoneNumber("1234567890", mustBeInternational: true),
        false,
      );
      expect(
        validatePhoneNumber("1234567890", mustBeInternational: true),
        false,
      );
    });
    test("double plus is not allowed", () {
      expect(validatePhoneNumber("++1234567890"), false);
    });
  });
}
