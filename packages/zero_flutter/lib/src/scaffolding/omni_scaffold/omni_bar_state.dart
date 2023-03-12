import 'package:zero_flutter/zero_flutter.dart';

part 'omni_bar_state.g.dart';

class BarState {
  const BarState({
    required this.open,
    required this.searching,
    required this.query,
  });

  final bool open;
  final bool searching;
  final String query;

  BarState copyWith({
    bool? open,
    bool? searching,
    String? query,
  }) {
    return BarState(
      open: open ?? this.open,
      searching: searching ?? this.searching,
      query: query ?? this.query,
    );
  }
}

@riverpod
class OmniBarState extends _$OmniBarState {
  @override
  BarState build() {
    return const BarState(
      open: false,
      searching: false,
      query: "",
    );
  }

  void setOpen(bool open) {
    state = state.copyWith(open: open);
  }

  void toggleOpen() {
    state = state.copyWith(open: !state.open);
  }

  void setSearching(bool searching) {
    state = state.copyWith(
      searching: searching,
      query: !searching ? "" : state.query,
    );
  }

  void setQuery(String query) {
    state = state.copyWith(query: query);
  }
}
