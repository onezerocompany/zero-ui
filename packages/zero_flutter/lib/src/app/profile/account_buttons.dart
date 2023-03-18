import 'package:firebase_auth/firebase_auth.dart';
import 'package:zero_flutter/zero_flutter.dart';

class AccountDeletionDialog extends ConsumerWidget {
  const AccountDeletionDialog({super.key});

  static show() {
    showDialog(
      const AccountDeletionDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(zeroLocalizationsProvider);
    return Dialog(
      confirmColor: Colors.error,
      confirmText: t.profile.deleteAccount.button,
      onConfirm: () {
        FirebaseAuth.instance.currentUser?.delete();
        Navigator.of(context).pop();
      },
      onDismiss: () => Navigator.of(context).pop(),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Section(
          itemSpacing: 18,
          children: [
            Text(
              t.profile.deleteAccount.button,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              t.profile.deleteAccount.warning,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}

class AccountButtons extends ConsumerWidget {
  const AccountButtons({
    super.key,
    this.canDeleteAccount = false,
  });

  final bool canDeleteAccount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(zeroLocalizationsProvider);
    return Section(
      itemSpacing: 16,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Button(
          config: Button.defaultConfig.copyWith(
            fillColor: Theme.of(context).colorScheme.onBackground,
            size: ButtonSize.medium,
            fillWidth: true,
          ),
          // label: ZeroUIAppLocalizations.of(context)!.signOut,
          label: t.profile.signOut,
          leading: Icons.logout,
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
        ),
        if (canDeleteAccount)
          Button(
            config: Button.defaultConfig.copyWith(
              size: ButtonSize.small,
              fillColor: Colors.error,
            ),
            leading: Icons.delete,
            label: t.profile.deleteAccount.button,
            onPressed: () {
              AccountDeletionDialog.show();
            },
          ),
      ],
    );
  }
}
