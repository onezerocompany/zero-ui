import 'package:onezero/onezero.dart';

class IndexPage extends ZeroPage {
  IndexPage({
    super.path = '/',
    super.id = 'index',
    super.name = 'Index Page',
    super.icon = Symbols.home,
    super.maxWidth = 500,
  });

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
