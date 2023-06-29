import 'package:onezero/onezero.dart';
import 'package:preview_app/screens/index.dart';

void main() {
  runApp(const PreviewApp());
}

class PreviewApp extends StatelessWidget {
  const PreviewApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OneZeroApp(
      pages: [
        IndexPage(),
      ],
    );
  }
}
