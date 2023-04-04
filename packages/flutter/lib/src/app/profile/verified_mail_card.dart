import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zero_ui/zero_ui.dart';
import 'package:url_launcher/url_launcher_string.dart';

class VerfiedMailCard extends HookConsumerWidget {
  const VerfiedMailCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(zeroLocalizationsProvider);
    final authConfig = ref.watch(authConfigProvider);

    final sending = useState(false);
    final response = useState<MailActionResponse?>(null);

    return Glass(
      state: GlassState.opaque,
      padding: const EdgeInsets.all(26),
      color: Theme.of(context).colorScheme.primary,
      cornerRadius: BorderRadius.circular(16),
      child: Section(
        itemSpacing: 16,
        children: [
          Section(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon: Icons.verified_user,
                size: 24,
                color: Theme.of(context).colorScheme.primary.foreground,
              ),
              Text(
                t.profile.verifyEmailCard.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary.foreground,
                    ),
              ),
            ],
          ),
          Text(
            t.profile.verifyEmailCard.message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary.foreground,
                ),
          ),
          AnimatedHider(
            visible: response.value?.sent == true,
            secondChild: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Button(
                loading: sending.value,
                config: Button.defaultConfig.copyWith(
                  fillWidth: true,
                  size: ButtonSize.medium,
                  fillColor: Theme.of(context).colorScheme.primary.foreground,
                  contentColor: Theme.of(context).colorScheme.primary,
                ),
                leading: Icons.send,
                label: t.profile.verifyEmailCard.buttons.resend,
                onPressed: () async {
                  sending.value = true;
                  try {
                    response.value =
                        await authConfig.sendMailVerification?.call();
                  } on FirebaseException catch (firebaseError) {
                    showFirebaseError(context, ref, error: firebaseError);
                  } catch (e) {
                    showFirebaseError(context, ref);
                  }
                  sending.value = false;
                },
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Section(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Section(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        icon: Icons.check,
                        size: 24,
                        color: Theme.of(context).colorScheme.primary.foreground,
                      ),
                      Text(
                        t.profile.verifyEmailCard.messages.sent,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .foreground,
                            ),
                      ),
                    ],
                  ),
                  if (response.value?.inboxUrl?.isNotEmpty == true)
                    Button(
                      label: "Open Inbox",
                      leading: Icons.inbox,
                      onPressed: () async {
                        // open inbox url in browser
                        if (await canLaunchUrlString(
                          response.value!.inboxUrl!,
                        )) {
                          await launchUrlString(
                            response.value!.inboxUrl!,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      },
                      config: Button.defaultConfig.copyWith(
                        size: ButtonSize.small,
                        fillColor:
                            Theme.of(context).colorScheme.primary.foreground,
                        contentColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
