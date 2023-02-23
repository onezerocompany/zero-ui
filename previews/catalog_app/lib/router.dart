import 'package:zero_flutter/zero_flutter.dart';

// pages
import 'package:zero_catalog/pages/components_page.dart';
import 'package:zero_catalog/pages/login.dart';

Router routerBuilder(BuildContext context, AuthConfig authConfig) {
  const componentsPage = ComponentsPage();
  return Router(
    context,
    authConfig: authConfig,
    initialPage: componentsPage,
    pages: [
      LoginPage(),
      componentsPage,
    ],
  );
}
