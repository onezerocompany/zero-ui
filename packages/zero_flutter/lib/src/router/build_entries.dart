import 'package:zero_flutter/zero_flutter.dart';

import 'router_entry.dart';

List<RouterEntry> buildEntries(
  Locale locale,
  List<PageBuilder> pages, {
  int level = 1,
  String? parentPath,
}) {
  return pages.map((page) {
    final renderedPage = page(null);
    final metadata = renderedPage.metadata(locale);
    final key = renderedPage.key;
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
    return RouterEntry(
      key: key,
      pageBuilder: page,
      level: level,
      subPath: subPath,
      fullPath: parentPath == null ? subPath : "$parentPath/$subPath",
      metadata: metadata,
      subentries: buildEntries(
        locale,
        metadata.subpages,
        level: level + 1,
        parentPath: parentPath == null ? subPath : "$parentPath/$subPath",
      ),
    );
  }).toList();
}
