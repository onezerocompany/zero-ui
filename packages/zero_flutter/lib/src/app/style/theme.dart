import 'package:zero_flutter/zero_flutter.dart';

export 'text.dart';

ThemeData themeDataFor({
  required Color primary,
  required Brightness brightness,
  required TextStyle primaryTextStyle,
  TextStyle? labelTextStyle,
  TextStyle? titleTextStyle,
}) {
  Colors colors = Colors(primary: primary);
  ColorScheme colorScheme =
      brightness == Brightness.light ? colors.lightScheme : colors.darkScheme;
  return ThemeData(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.background,
    brightness: brightness,
    textTheme: textTheme(
      primaryTextStyle: primaryTextStyle,
      titleTextStyle: titleTextStyle,
      labelTextStyle: labelTextStyle,
    ),
    useMaterial3: true,
  );
}
