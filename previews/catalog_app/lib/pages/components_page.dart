import 'package:go_router/go_router.dart';
import 'package:zero_flutter/zero_flutter.dart';
import 'package:zero_catalog/components/buttons.dart';
import 'package:zero_catalog/components/inputs.dart';
import 'package:zero_catalog/components/loader.dart';
import 'package:zero_catalog/components/text.dart';
import 'package:zero_catalog/components/camera_page.dart';

List<Page> componentPages = [
  const TextPage(),
  const ButtonsPage(),
  const LoaderPage(),
  const InputsPage(),
  const CameraPage(),
];

class ComponentsPage extends Page {
  const ComponentsPage({
    super.key,
  });

  @override
  PageMetadata metadata(BuildContext context) {
    return PageMetadata(
      path: "/catalog",
      icon: Icons.home,
      name: (context) => "Components",
      subpages: componentPages,
    );
  }

  @override
  PageContentBuilder? get contentBuilder => (context, ref, landscape) {
        return PageContent(
          maxWidth: 500,
          itemCount: componentPages.length,
          itemBuilder: (
            BuildContext context,
            int index,
          ) {
            if (index > componentPages.length - 1) {
              return ListItem(
                key: ValueKey(index),
                label: "Tester $index",
                icon: Icons.note,
                trailingArrow: true,
                config: ListItem.defaultConfig.copyWith(
                  glassLike: true,
                  fillColor: Theme.of(context).colorScheme.background,
                ),
              );
            }
            PageMetadata metadata = componentPages[index].metadata(context);
            return ListItem(
              key: ValueKey(metadata.path),
              label: metadata.name?.call(context) ?? "",
              sublabel: metadata.description?.call(context),
              icon: metadata.icon,
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
          },
        );
      };
}
