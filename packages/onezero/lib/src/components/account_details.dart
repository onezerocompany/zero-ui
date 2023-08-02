import 'package:onezero/onezero.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ZeroTheme.of(context);
    final iconColor = DynamicColor(
      lightRootColor: const Color.fromARGB(255, 247, 245, 245),
    );
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.colors.card.edge.resolve(context),
                  width: 3,
                ),
              ),
              child: ClipOval(
                  child: Container(
                color: iconColor.resolve(context),
                width: 38,
                height: 38,
                child: const Icon(icon: Symbols.person),
              )),
            ),
          ],
        ),
      ],
    );
  }
}
