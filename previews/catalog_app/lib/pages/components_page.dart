import 'package:go_router/go_router.dart';
import 'package:zero_ui/zero_ui.dart';
import 'package:zero_catalog/components/buttons.dart';
import 'package:zero_catalog/components/inputs.dart';
import 'package:zero_catalog/components/loader.dart';
import 'package:zero_catalog/components/text.dart';

List<PageBuilder> componentPages = [
  (state) => TextPage(state),
  (state) => ButtonsPage(state),
  (state) => LoaderPage(state),
  (state) => InputsPage(state),
];

PageMetadata componentsPageMetadata(Locale locale) {
  return PageMetadata(
    path: "/catalog",
    icon: Icons.home,
    name: "Components",
    subpages: componentPages,
  );
}

class ComponentsPage extends Page {
  const ComponentsPage(
    super.state, {
    super.key,
    super.metadata = componentsPageMetadata,
  });

  @override
  PageContentBuilder? get contentBuilder => (context, ref, landscape) {
        final locale = ref.watch(currentLocaleProvider);
        return PageContent(
          maxWidth: 500,
          leadingItems: componentPages.map((page) {
            PageMetadata metadata = page(null).metadata(locale);
            return ListItem(
              key: ValueKey(metadata.path),
              label: metadata.name,
              sublabel: metadata.description,
              leading: metadata.icon,
              trailingArrow: true,
              config: ListItem.defaultConfig.copyWith(
                glassLike: true,
                fillColor: Theme.of(context).colorScheme.background,
              ),
              onPressed: () {
                GoRouter.of(context).go(
                  "/catalog${metadata.path}",
                );
              },
            );
          }).toList(),
        );
      };
}
