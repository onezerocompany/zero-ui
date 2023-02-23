import 'package:go_router/go_router.dart';
import 'package:zero_flutter/zero_flutter.dart';

typedef MetadataBuilder = PageMetadata Function();

/// The metadata of a page
///
/// This is used mostly by the internal router system.
/// It's also used to generate link buttons and link previews.
@immutable
class PageMetadata {
  const PageMetadata({
    required this.path,
    this.name,
    this.description,
    this.icon,
    this.data = const {},
    this.subpages = const [],
    this.color,
    this.searchable = true,
    this.hideOmniBar = false,
    this.requiredScopes = const [],
  });

  /// The path to the page
  /// e.g. /subpage
  ///
  /// This is used to generate the route for the page
  /// If the path is not specified, the page will not be routable
  /// and will not be added to the navigation stack
  ///
  /// If the path is specified, it must be unique
  final String path;

  /// The name of the page
  /// e.g. 'Hello World Page'
  ///
  /// This is used to generate the title at the top of the page
  /// If the name is not specified, the page will not have a title
  final String Function(BuildContext context)? name;

  /// The description of the page
  /// e.g. 'This is a page that says hello world'
  ///
  /// This is used in link previews and search results
  /// If the description is not specified, the page will not have a description
  final String Function(BuildContext context)? description;

  /// The icon of the page
  /// e.g. Iconsax.home
  ///
  /// This is used to generate the icon at the top of the page
  /// If the icon is not specified, the page will not have an icon
  final IconData? icon;

  /// Custom data for the page
  /// e.g. {'allowedUserTypes': ['admin', 'moderator']}
  ///
  /// This is used to store custom data for the page
  /// If the data is not specified, the page will not have any custom data
  final Map<String, dynamic> data;

  /// Subpages of the page
  /// e.g. [Page1(), Page2()]
  ///
  /// This is used in the router to generate the routes for the subpages
  /// If the subpages are not specified, the page will not have any subpages
  final List<Page> subpages;

  /// Color of the page, used for link previews
  final Color? color;

  /// Whether the page shows up in search results
  /// and the omni search bar home view
  ///
  /// Defaults to true
  final bool searchable;

  /// hides the omni bar
  final bool hideOmniBar;

  /// Required auth scopes
  /// e.g. ['admin', 'moderator']
  final List<String> requiredScopes;

  /// Resolves the path to a full path including the parent path
  /// e.g. /page/subpage
  String resolvedPath(
    BuildContext context, {
    Page? parent,
    fullPath = false,
  }) {
    String resolved = path;
    if (parent?.metadata(context).path == null) {
      // add leading slash if it's not present
      if (!resolved.startsWith('/')) resolved = '/$resolved';
    } else {
      if (fullPath) {
        resolved = parent!.metadata(context).resolvedPath(context) + resolved;
      } else if (resolved.startsWith('/')) {
        resolved = resolved.substring(1);
      }
    }

    // remove trailing slash
    if (resolved.endsWith('/')) {
      resolved = resolved.substring(0, resolved.length - 1);
    }

    return resolved;
  }

  /// Resolves the subpages to a list of routes
  /// e.g. [Route1(), Route2()]
  ///
  /// This is used in the router to generate the routes for the subpages
  /// If a subpage is not routable, it will not be included in the list
  List<RouteBase> subroutes(
    BuildContext context, {
    Page? parent,
    required int level,
  }) {
    return subpages
        .map(
          (page) => page.route(
            context,
            parent: parent,
            level: level,
          ),
        )
        .whereType<RouteBase>()
        .toList();
  }
}
