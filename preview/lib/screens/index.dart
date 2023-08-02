import 'package:onezero/onezero.dart';
import 'package:preview_app/screens/text.dart';

class IndexPage extends ZeroPage {
  IndexPage({
    super.path = '/',
    super.id = 'index',
    super.name = 'Index Page',
    super.icon = Symbols.home_rounded,
    super.maxWidth = 500,
  });

  @override
  List<ZeroPage> get children => [
        TextPage(),
      ];

  @override
  Widget build(
    BuildContext context,
    ContainerColors colors,
    Typography typography,
  ) {
    return const Column(
      children: [
        Card(),
      ],
    );
  }
}
