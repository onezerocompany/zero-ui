import 'package:zero_flutter/zero_flutter.dart';

class SectionFooter extends StatelessWidget {
  const SectionFooter({
    super.key,
    required this.footer,
    required this.itemSpacing,
  });

  final String? footer;
  final double itemSpacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: itemSpacing),
      child: Text(
        footer!,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
