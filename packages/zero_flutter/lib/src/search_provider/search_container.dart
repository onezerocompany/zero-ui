import 'package:zero_flutter/zero_flutter.dart';

class SearchContainer extends StatefulWidget {
  final Widget child;

  const SearchContainer({
    super.key,
    required this.child,
  });

  @override
  State<StatefulWidget> createState() {
    return SearchContainerState();
  }
}

class SearchContainerState extends State<SearchContainer> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final config = AppConfig.of(context);
    final providers = globalContainer.read(searchProviders);
    for (final searchProvider in config.searchProviders) {
      final provider = searchProvider(context);
      if (!providers.contains(provider)) {
        providers.add(provider);
      }
    }
    globalContainer.read(searchProviders.notifier).state = providers;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
