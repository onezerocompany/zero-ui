import 'package:flutter/services.dart' hide TextInput;
import 'package:zero_flutter/zero_flutter.dart';

class PhoneNumberField extends ConsumerWidget {
  const PhoneNumberField(
    this.formController, {
    super.key,
    this.storedPhoneNumber,
  });

  final FormController? formController;
  final String? storedPhoneNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(zeroLocalizationsProvider);
    return TextInput(
      InputState<String>(
        id: "phone",
        defaultValue: "",
        storedValue: storedPhoneNumber,
        validator: (value) {
          if (value?.isEmpty == true) return "required";
          if (!validatePhoneNumber(value!)) return "invalid";
          return null;
        },
        sanitizer: (value, {forStoring = false}) {
          // replace all non-digit and non plus characters with empty string
          var sanitized = value?.replaceAll(RegExp(r'[^0-9+]'), '') ?? "";
          // add space after every 2 characters
          // except for the first {3} {1} then all {2}...
          // like this: '+31 6 98 76 54 32'
          var spaced = '';
          for (var i = 0; i < sanitized.length; i++) {
            if (i == 0) {
              spaced += sanitized[i];
            } else if (i == 1) {
              spaced += sanitized[i];
            } else if (i == 2) {
              spaced += sanitized[i];
            } else if (i == 3) {
              spaced += ' ${sanitized[i]}';
            } else if (i % 2 == 0) {
              spaced += ' ${sanitized[i]}';
            } else {
              spaced += sanitized[i];
            }
          }
          sanitized = spaced;

          if (sanitized.isNotEmpty &&
              (!sanitized.startsWith('+') || !sanitized.startsWith('(+'))) {
            sanitized = '+$sanitized';
          }

          // replace +06 with +31 6
          sanitized = sanitized.replaceAll(RegExp(r'\+06'), '+31 6');

          // remove any additional + that are not the first character
          sanitized = sanitized.replaceAll(RegExp(r'(?<!^)\+'), '');

          return sanitized.trim();
        },
      ),
      label: t.profile.fields.phone.label,
      placeholder: t.profile.fields.phone.enter,
      leading: Icons.phone,
      autofillHints: const [AutofillHints.telephoneNumber],
      inputFormatters: [
        FilteringTextInputFormatter.allow(phoneNumberCharacters),
      ],
      errorBuilder: (context, code) {
        if (code == "required") return t.profile.fields.phone.required;
        return t.profile.fields.phone.invalid;
      },
    );
  }
}
