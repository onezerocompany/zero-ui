import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zero_catalog/router.dart';
import 'package:zero_ui/zero_ui.dart';

final configBuilder = AppConfigBuilder(
  appName: (locale) => "Zero Catalog",
  locales: [const Locale("en"), const Locale("nl")],
  style: styleConfig,
  auth: authConfigBuilder,
  router: routerBuilder,
  omni: omniConfigBuilder,
);

final styleConfig = StyleConfig(
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
);

AuthConfig authConfigBuilder(Locale locale) => AuthConfig(
      authMethods: [
        AuthMethods.anonymous,
        AuthMethods.magicLink,
        AuthMethods.password,
        // AuthMethods.google,
        // AuthMethods.apple,
      ],
      profileLink: "/catalog/profile",
      signInLink: "/login",
      sendMailVerification: () async {
        final call = await FirebaseFunctions.instanceFor(region: "europe-west1")
            .httpsCallable(
          "accounts-sendMailVerification",
        )
            .call({
          "appUrl": kIsWeb ? Uri.base.origin : "https://zeroui.onezero.company",
        });
        return MailActionResponse(
          sent: call.data["sent"] ?? false,
          inboxUrl: call.data["inboxUrl"],
        );
      },
    );

OmniConfig omniConfigBuilder(Locale locale) {
  final router = routerBuilder(locale);
  return OmniConfig(
    searchProviders: [PageSearchProvider(entries: router.entries)],
    searchEnabled: true,
  );
}
