import 'package:flutter/widgets.dart';
import 'package:zero_ui/zero_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const ZeroApp(
      theme: ZeroTheme(
          colors: ZeroThemeColors(
            primary: ZeroColor(
                color: Color.fromRGBO(255, 255, 255, 1),
                onColor: Color.fromARGB(255, 46, 47, 46)),
            surface: ZeroColor(
                color: Color.fromRGBO(226, 222, 231, 1),
                onColor: Color.fromRGBO(0, 0, 255, 1)),
          ),
          typography: ZeroThemeTypography()),
    );
  }
}
