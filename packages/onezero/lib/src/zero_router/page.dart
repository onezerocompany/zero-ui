// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';
import 'package:onezero/onezero.dart';

class ZeroPage {
  /// Constructs a [ZeroPage].
  /// - [path] and [id] cannot be empty strings.
  /// - One of either [build] or [pageBuilder] must be provided.
  ZeroPage({
    required this.path,
    required this.id,
    required this.name,
    required this.icon,
    double minWidth = 300,
    this.maxWidth = double.infinity,
    this.collapsedWidth,
    this.parentNavigatorKey,
    this.redirect,
    this.children = const <ZeroPage>[],
  })  : assert(path.isNotEmpty, 'ZeroPage path cannot be empty'),
        assert(id.isNotEmpty, 'ZeroPage name cannot be empty'),
        minWidth = maxWidth < minWidth ? maxWidth : minWidth {
    _pathRE = patternToRegExp(path, pathParameters);
  }

  final List<ZeroPage> children;

  final GlobalKey<NavigatorState>? parentNavigatorKey;

  static Iterable<ZeroPage> childrenRecursively(Iterable<ZeroPage> routes) {
    return routes.expand(
      (ZeroPage e) => <ZeroPage>[
        e,
        ...childrenRecursively(e.children),
      ],
    );
  }

  final String id;
  final String path;
  final String name;
  final IconData icon;

  final double minWidth;
  final double maxWidth;
  final double? collapsedWidth;

  final ZeroRouterRedirect? redirect;

  RegExpMatch? matchPatternAsPrefix(String loc) =>
      _pathRE.matchAsPrefix(loc) as RegExpMatch?;

  /// Extract the path parameters from a match.
  Map<String, String> extractPathParams(RegExpMatch match) =>
      extractPathParameters(pathParameters, match);

  /// The path parameters in this route.
  @internal
  final List<String> pathParameters = <String>[];

  @internal
  Widget buildPage(
    BuildContext context,
  ) {
    final theme = ZeroTheme.of(context);
    return Card(
      icon: icon,
      title: name,
      subtitle: id,
      colors: theme.colors.page,
      expanded: true,
      edgeRadius: 16,
      child: build(context, theme.colors.page, theme.typography),
    );
  }

  @override
  String toString() {
    return 'ZeroPage(name: $id, path: $path)';
  }

  Widget build(
    BuildContext context,
    ContainerColors colors,
    Typography typography,
  ) {
    return const SizedBox.shrink();
  }

  late final RegExp _pathRE;
}
