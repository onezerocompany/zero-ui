import 'package:zero_ui/zero_ui.dart';

/// The metadata of a page
///
/// This is used mostly by the internal router system.
/// It's also used to generate link buttons and link previews.
@immutable
class PageMetadata {
  const PageMetadata({
    this.parent,
    required this.path,
    required this.name,
    this.description,
    this.icon,
    this.data = const {},
    this.subpages = const [],
    this.color,
    this.searchable = true,
    this.hideOmniBar = false,
    this.hasAccess,
  });

  /// Parent to this page
  final PageMetadata? parent;

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
  final String name;

  /// The description of the page
  /// e.g. 'This is a page that says hello world'
  ///
  /// This is used in link previews and search results
  /// If the description is not specified, the page will not have a description
  final String? description;

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
  final List<PageBuilder> subpages;

  /// Color of the page, used for link previews
  final Color? color;

  /// Whether the page shows up in search results
  /// and the omni search bar home view
  ///
  /// Defaults to true
  final bool searchable;

  /// Hides the ombi search bar on the page
  final bool hideOmniBar;

  /// Function that validates if the user is allowed to access the page
  /// e.g. (context) => context.read(userProvider).isAdmin
  /// e.g. (context) => context.read(userProvider).isModerator
  final bool Function()? hasAccess;
}
