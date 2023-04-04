import 'package:zero_ui/zero_ui.dart';

export '../../search_provider/search_provider.dart';

part 'omni_config.g.dart';

@Riverpod(keepAlive: true)
OmniConfig omniConfig(OmniConfigRef ref) {
  final config = ref.watch(appConfigProvider);
  return config.omni;
}

class OmniConfig {
  const OmniConfig({
    this.searchEnabled = false,
    this.searchProviders = const [],
  });

  final bool searchEnabled;
  final List<SearchProvider> searchProviders;
}
