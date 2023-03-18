import 'package:zero_flutter/zero_flutter.dart';

class RouterEntry {
  final Key? key;
  final int level;
  final String fullPath;
  final String subPath;
  final PageBuilder pageBuilder;
  final PageMetadata metadata;
  final List<RouterEntry> subentries;

  const RouterEntry({
    this.key,
    required this.level,
    required this.fullPath,
    required this.subPath,
    required this.metadata,
    required this.pageBuilder,
    this.subentries = const [],
  });
}
