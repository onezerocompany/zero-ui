import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zero_flutter/zero_flutter.dart';

export 'config/app_config.dart';

final globalContainer = ProviderContainer();

class App extends StatefulWidget {
  const App({
    super.key,
    required this.config,
  });

  final AppConfigData Function(BuildContext context) config;

  static void prepare() {
    WidgetsFlutterBinding.ensureInitialized();
    Paint.enableDithering = true;
  }

  void run() async {
    App.prepare();
    runApp(this);
  }

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late AppConfigData config;

  @override
  initState() {
    super.initState();
    config = widget.config(context);
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null &&
          config.router.currentPath != config.authConfig.signInLink &&
          !config.authConfig.anonymousEnabled) {
        config.router.go(config.authConfig.signInLink);
      } else if (user != null &&
          config.router.currentPath == config.authConfig.signInLink) {
        config.router.go('/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = config.style;
    return UncontrolledProviderScope(
      container: globalContainer,
      child: AppConfig(
        config: config,
        child: MaterialApp.router(
          title: config.name,
          onGenerateTitle: (context) => config.name,
          routerConfig: config.router.goRouter,
          localizationsDelegates: [
            ...config.localizationsDelegates,
            ZeroUIAppLocalizations.delegate,
          ],
          supportedLocales: config.supportedLocales,
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
        ),
      ),
    );
  }
}
