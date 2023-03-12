import 'package:flutter/services.dart' hide TextInput;
import 'package:zero_flutter/zero_flutter.dart';

class EmailAddressField extends ConsumerWidget {
  const EmailAddressField(
    this.state, {
    super.key,
    this.storedEmailAddress,
    required this.showChangeNotice,
    required this.showChangeEmailSent,
  });

  final InputState<String> state;
  final String? storedEmailAddress;
  final bool showChangeNotice;
  final bool showChangeEmailSent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(zeroLocalizationsProvider);
    return Column(
      children: [
        TextInput(
          InputState<String>(
            id: "email",
            defaultValue: "",
            storedValue: storedEmailAddress,
            validator: (String? value) {
              if (value == null || value.isEmpty) return "required";
              if (!validateEmailAddress(value)) return "invalid";
              return null;
            },
          ),
          label: t.profile.fields.email.label,
          placeholder: t.profile.fields.email.enter,
          leading: Icons.email,
          autofillHints: const [AutofillHints.email],
          keyboardType: TextInputType.emailAddress,
          inputFormatters: [
            FilteringTextInputFormatter.allow(emailAddressCharacters),
          ],
          errorBuilder: (context, code) {
            if (code == "required") {
              return t.profile.fields.email.required;
            }
            return t.profile.fields.email.invalid;
          },
        ),
        AnimatedHider(
          visible: showChangeNotice,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: InlineMessage(
              icon: Icons.info,
              message: t.profile.fields.email.notices.change,
            ),
          ),
        ),
        AnimatedHider(
          visible: showChangeEmailSent,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: InlineMessage(
              icon: Icons.send,
              message: t.profile.fields.email.notices.changeSent,
            ),
          ),
        ),
      ],
    );
  }
}
