class MultiScaffoldState {
  const MultiScaffoldState({
    required this.multiPage,
    required this.showingSecondPage,
  });

  /// Whether the scaffold is currently in a multi mode
  final double multiPage;

  /// The current page of the multi scaffold
  /// 0 = left, 1 = right
  final double showingSecondPage;

  MultiScaffoldState operator +(MultiScaffoldState other) {
    return MultiScaffoldState(
      multiPage: multiPage + other.multiPage,
      showingSecondPage: showingSecondPage + other.showingSecondPage,
    );
  }

  MultiScaffoldState operator -(MultiScaffoldState other) {
    return MultiScaffoldState(
      multiPage: multiPage - other.multiPage,
      showingSecondPage: showingSecondPage - other.showingSecondPage,
    );
  }

  MultiScaffoldState operator *(double other) {
    return MultiScaffoldState(
      multiPage: multiPage * other,
      showingSecondPage: showingSecondPage * other,
    );
  }

  MultiScaffoldState operator /(double other) {
    return MultiScaffoldState(
      multiPage: multiPage / other,
      showingSecondPage: showingSecondPage / other,
    );
  }
}
