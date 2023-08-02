import 'package:onezero/onezero.dart';

class TextPage extends ZeroPage {
  TextPage({
    super.path = 'text',
    super.id = 'text',
    super.name = 'Text Page',
    super.icon = Symbols.text_snippet,
    super.maxWidth = 800,
  });

  @override
  Widget build(
    BuildContext context,
    ContainerColors colors,
    Typography typography,
  ) {
    return Column(
      children: [
        for (var category in TypographyCategoryType.values)
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              children: [
                for (var size in TypographySize.values.reversed)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      category.toString(),
                      style: typography
                          .categoryForType(category)
                          .styleForSize(size),
                    ),
                  ),
              ],
            ),
          )
      ],
    );
  }
}
