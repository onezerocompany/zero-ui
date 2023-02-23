import 'package:zero_flutter/zero_flutter.dart';

class CardsPage extends Page {
  const CardsPage({
    super.key,
  });

  @override
  PageMetadata metadata(BuildContext context) {
    return PageMetadata(
      path: "/cards",
      name: (context) => "Cards",
      description: (context) =>
          "Used for displaying content in a structured manner.",
    );
  }
}
