import 'package:zero_ui/zero_ui.dart';

class NameField extends HookConsumerWidget {
  const NameField(
    this.controller, {
    super.key,
    this.storedName,
  });

  final FormController controller;
  final String? storedName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(zeroLocalizationsProvider);
    return TextInput(
      useMemoized(
        () => InputState<String>(
          id: "name",
          defaultValue: "",
          storedValue: storedName,
          formController: controller,
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
