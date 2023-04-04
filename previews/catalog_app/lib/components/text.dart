import 'package:zero_ui/zero_ui.dart';

PageMetadata textPageMetadata(Locale locale) {
  return const PageMetadata(
    path: "/text",
    icon: Icons.text_format,
    name: "Text",
    description: "Different text styles",
  );
}

class TextPage extends Page {
  const TextPage(
    super.state, {
    super.metadata = textPageMetadata,
    super.key,
    super.layout = PageLayout.card,
  });

  @override
  PageContentBuilder? get contentBuilder => (context, ref, landscape) {
        TextTheme textTheme = Theme.of(context).textTheme;
        return PageContent(
          child: Section(
            itemSpacing: 8,
            children: [
              Text("Display Large", style: textTheme.displayLarge),
              Text("Display Medium", style: textTheme.displayMedium),
              Text("Display Small", style: textTheme.displaySmall),
              Text("Headline Large", style: textTheme.headlineLarge),
              Text("Headline Medium", style: textTheme.headlineMedium),
              Text("Headline Small", style: textTheme.headlineSmall),
              Text("Title Large", style: textTheme.titleLarge),
              Text("Title Medium", style: textTheme.titleMedium),
              Text("Title Small", style: textTheme.titleSmall),
              Text("Label Large", style: textTheme.labelLarge),
              Text("Label Medium", style: textTheme.labelMedium),
              Text("Label Small", style: textTheme.labelSmall),
              Text("Body Large", style: textTheme.bodyLarge),
              Text("Body Medium", style: textTheme.bodyMedium),
              Text("Body Small", style: textTheme.bodySmall),
            ],
          ),
        );
      };
}
