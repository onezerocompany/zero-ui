import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zero_flutter/zero_flutter.dart';
import 'package:zero_catalog/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_options.dart';

Uint8List? testImageBytes;

final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
final functions = FirebaseFunctions.instanceFor(region: "europe-west1");

Future<void> main() async {
  App.prepare();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // use firebase auth emulator when on debug
  if (kDebugMode) {
    print("using firebase emulators");
    await auth.useAuthEmulator('10.0.0.15', 5001);
    firestore.useFirestoreEmulator("10.0.0.15", 5002);
    functions.useFunctionsEmulator(
      "10.0.0.15",
      5003,
    );
  }

  testImageBytes = (await rootBundle.load('assets/images/dalle-static.png'))
      .buffer
      .asUint8List();

  var buttons = [
    const OmniButtonData(
      icon: Icons.camera_alt,
      link: '/catalog/buttons',
    ),
    const OmniButtonData(
      icon: Icons.person,
      link: '/catalog',
    ),
  ];
  var app = App(
    config: (context) {
      const authConfig = AuthConfig(
        authMethods: [
          // AuthMethods.anonymous,
          AuthMethods.magicLink,
          AuthMethods.password,
          // AuthMethods.google,
          // AuthMethods.apple,
        ],
        profileLink: "/catalog/profile",
        signInLink: "/login",
      );
      final router = routerBuilder(context, authConfig);
      return AppConfigData(
        context,
        name: "ZeroUI Catalog",
        router: router,
        authConfig: authConfig,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        style: StyleConfig(
          primaryColor: const Color.fromARGB(255, 67, 54, 190),
          primaryTextStyle: GoogleFonts.lato(),
          // background: (context) =>
          //     ColoredBox(color: Theme.of(context).colorScheme.primaryContainer),
          background: (context) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            return ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(isDark ? 0.6 : 0.1),
                BlendMode.luminosity,
              ),
              child: Image.network(
                'https://images.unsplash.com/photo-1676313683383-c36a9d41489a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2232&q=80',
                fit: BoxFit.cover,
              ),
            );
          },
        ),
        buttons: buttons,
        searchProviders: [
          (context) => PageSearchProvider(
                context,
                pages: router.pages,
              ),
        ],
      );
    },
  );
  app.run();
}
