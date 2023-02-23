import 'package:zero_flutter/zero_flutter.dart';

export 'app_config_data.dart';
export 'router.dart';

class AppConfig extends InheritedWidget {
  final AppConfigData _data;

  const AppConfig({
    super.key,
    required super.child,
    required AppConfigData config,
  }) : _data = config;

  static AppConfigData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>()!._data;
  }

  static Router router(BuildContext context) {
    return of(context).router;
  }

  static List<SearchProvider Function(BuildContext context)> searchProviders(
    BuildContext context,
  ) {
    return of(context).searchProviders;
  }

  static StyleConfig style(BuildContext context) {
    return of(context).style;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // app config should never change during runtime
    return false;
  }
}
