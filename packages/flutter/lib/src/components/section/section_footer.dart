import 'package:zero_ui/zero_ui.dart';

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
