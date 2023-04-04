import 'package:zero_ui/zero_ui.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

export 'zero_app_state.dart';

class ZeroApp extends StatelessWidget {
  const ZeroApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UncontrolledProviderScope(
      container: globalContainer,
      child: const _ZeroApp(),
    );
  }
}

class _ZeroApp extends ConsumerWidget {
  const _ZeroApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final style = ref.watch(styleConfigProvider);
    final locale = ref.watch(currentLocaleProvider);
    return MaterialApp.router(
      title: config.appName,
      onGenerateTitle: (context) => config.appName,
      routerConfig: config.router.goRouter,
      locale: locale,
      supportedLocales: config.locales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: themeDataFor(
        primary: style.primaryColor,
        brightness: Brightness.light,
        primaryTextStyle: style.primaryTextStyle,
        titleTextStyle: style.titleTextStyle,
        labelTextStyle: style.labelTextStyle,
      ),
      darkTheme: themeDataFor(
        primary: style.primaryColor,
        brightness: Brightness.dark,
        primaryTextStyle: style.primaryTextStyle,
        titleTextStyle: style.titleTextStyle,
        labelTextStyle: style.labelTextStyle,
      ),
      // hide debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}
