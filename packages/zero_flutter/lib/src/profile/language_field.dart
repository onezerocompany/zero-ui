import 'package:flutter_svg/svg.dart';
import 'package:zero_flutter/zero_flutter.dart';

import 'languages.dart';

class LanguageField extends ConsumerWidget {
  const LanguageField(
    this.formController, {
    super.key,
    this.storedLanguage,
  });

  final FormController formController;
  final String? storedLanguage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(zeroLocalizationsProvider);
    final config = ref.watch(appConfigProvider);

    return OptionsInput(
      InputState<String>(
        id: "language",
        defaultValue: "en",
        storedValue: storedLanguage,
      ),
      label: t.profile.fields.language.label,
      selectLabel: t.profile.fields.language.select,
      leading: Icons.language,
      options: config.locales.map((locale) {
        final language = findLanguageForCode(locale.languageCode);
        return InputOption<String>(
          label: language?.nativeName ?? locale.languageCode,
          value: locale.languageCode,
          icon: SvgPicture.asset(
            "assets/flags/${locale.languageCode}.svg",
            package: "zero_flutter",
            width: 24,
            height: 24,
          ),
        );
      }).toList(),
    );
  }
}
