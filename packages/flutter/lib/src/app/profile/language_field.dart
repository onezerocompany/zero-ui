import 'package:flutter_svg/svg.dart';
import 'package:zero_ui/zero_ui.dart';

class LanguageField extends HookConsumerWidget {
  const LanguageField(
    this.controller, {
    super.key,
    this.storedLanguage,
  });

  final FormController controller;
  final String? storedLanguage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(zeroLocalizationsProvider);
    final config = ref.watch(appConfigProvider);
    return OptionsInput<String>(
      useMemoized(
        () => InputState<String>(
          id: "language",
          defaultValue: "en",
          formController: controller,
          storedValue: storedLanguage,
        ),
      ),
      label: t.profile.fields.language.label,
      leading: Icons.language,
      options: () =>
          config.locales.map((locale) => locale.languageCode).toList(),
      optionBuilder: (state) {
        final language = findLanguageForCode(state.value ?? "en");
        return Button(
          config: state.templateButtonConfig,
          label: language?.nativeName ?? state.value ?? "en",
          leading: SvgPicture.asset(
            "assets/flags/${state.value ?? "en"}.svg",
            package: "zero_ui",
            width: 24,
            height: 24,
          ),
          onPressed: state.pressed,
        );
      },
    );
  }
}
