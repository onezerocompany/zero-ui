import 'package:zero_ui/zero_ui.dart';

List<RouterEntry> buildEntries(
  Locale locale,
  List<PageBuilder> pages, {
  int level = 1,
  String? parentPath,
}) {
  return pages.map((page) {
    final renderedPage = page(null);
    final metadata = renderedPage.metadata(locale);
    var subPath = metadata.path;
    // strip leading slash
    if (subPath.startsWith("/")) {
      subPath = subPath.substring(1);
    }
    // strip trailing slash
    if (subPath.endsWith("/")) {
      subPath = subPath.substring(0, subPath.length - 1);
    }
    // if level is 0 and there is no parent path, add a leading slash
    if (level == 1 && parentPath == null) {
      subPath = "/$subPath";
    }

    final fullPath = parentPath == null ? subPath : "$parentPath/$subPath";

    return RouterEntry(
      key: ValueKey(fullPath),
      pageBuilder: page,
      level: level,
      subPath: subPath,
      fullPath: fullPath,
      metadata: metadata,
      subentries: buildEntries(
        locale,
        metadata.subpages,
        level: level + 1,
        parentPath: fullPath,
      ),
    );
  }).toList();
}
