import 'package:zero_flutter/zero_flutter.dart';

class NameField extends ConsumerWidget {
  const NameField(
    this.formController, {
    super.key,
    this.storedName,
  });

  final FormController formController;
  final String? storedName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(zeroLocalizationsProvider);
    return TextInput(
      InputState<String>(
        id: "name",
        defaultValue: "",
        storedValue: storedName,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "required";
          }
          return null;
        },
        sanitizer: (value, {forStoring = false}) {
          // remove double spaces
          var sanitized = value?.replaceAll(RegExp(r'  '), ' ') ?? '';
          // remove leading spaces
          sanitized = sanitized.replaceAll(RegExp(r'^ '), '');
          // remove trailing spaces if storing
          if (forStoring) {
            sanitized = sanitized.replaceAll(RegExp(r' $'), '');
          }
          return sanitized;
        },
      ),
      label: t.profile.fields.name.label,
      placeholder: t.profile.fields.name.enter,
      leading: Icons.person,
      autofillHints: const [AutofillHints.name],
      keyboardType: TextInputType.name,
      errorBuilder: (context, errorCode) {
        if (errorCode == "required") return t.profile.fields.name.required;
        return null;
      },
    );
  }
}
