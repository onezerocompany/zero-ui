import 'package:url_launcher/url_launcher.dart';
import 'package:zero_flutter/zero_flutter.dart';

class MagicLinkNotice extends ConsumerWidget {
  const MagicLinkNotice({
    super.key,
    required this.inboxUrl,
  });

  final String? inboxUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(zeroLocalizationsProvider);
    return Section(
      itemSpacing: 22,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              leading: Icons.arrow_back,
              label: t.login.buttons.back,
              onPressed: () {
                ref.read(loginModeProvider.notifier).state =
                    LoginMode.magicLink;
              },
            ),
            Text(
              t.login.magicLink.sent.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        Text(
          t.login.magicLink.sent.message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        if (inboxUrl != null)
          Button(
            leading: Icons.inbox,
            label: t.login.magicLink.buttons.inbox,
            onPressed: () async {
              final uri = Uri.parse(inboxUrl!);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            },
            config: Button.defaultConfig.copyWith(
              size: ButtonSize.medium,
              fillColor: Theme.of(context).colorScheme.onSurface,
            ),
          ),
      ],
    );
  }
}
