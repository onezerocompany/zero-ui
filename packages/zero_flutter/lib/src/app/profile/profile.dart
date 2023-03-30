import 'package:firebase_auth/firebase_auth.dart';
import 'package:zero_flutter/zero_flutter.dart';

// inputs
export '../data/user_profile_data.dart';
export 'language_field.dart';
export 'name_field.dart';
export 'password_change.dart';
export 'phone_number_field.dart';
export 'verified_mail_card.dart';
export 'account_buttons.dart';
export 'email_address_field.dart';

class ProfileScreen extends Page {
  const ProfileScreen(
    super.state, {
    required super.metadata,
    super.key,
    super.layout = PageLayout.card,
    required this.userProfileProvider,
  });

  final AutoDisposeStreamProvider<UserProfileData?> userProfileProvider;

  @override
  PageContentBuilder? get contentBuilder => (context, ref, isHorizontal) {
        final profile = ref.watch(userProfileProvider);

        return PageContent(
          maxWidth: 430,
          child: profile.when(
            data: (profile) {
              return ProfileForm(profile: profile);
            },
            error: (error, stackTrace) => const Center(
              child: Text("Error"),
            ),
            loading: () => const Center(
              child: Loader(),
            ),
          ),
        );
      };
}

class ProfileForm extends HookConsumerWidget {
  const ProfileForm({
    super.key,
    required this.profile,
  });

  final UserProfileData? profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authConfig = ref.watch(authConfigProvider);
    final enabledAuths = ref.watch(enabledAuthMethodsProvider);

    final sentChangeEmail = useState(false);

    return InputForm(
      saveButtonPosition: FormButtonsPosition.bottom,
      onSaved: (values, saved) async {
        final uid = ref.read(userIdProvider).value;
        if (uid == null) {
          showFirebaseError(
            context,
            ref,
            error: FirebaseException(
              plugin: "auth",
              code: "unauthenticated",
            ),
          );
          return;
        }
        try {
          await authConfig.saveProfileDetails?.call(uid, values);

          // if the email was changed, set mail sent
          if (values.get<String>("email") != profile?.email) {
            sentChangeEmail.value = true;
          }

          saved();
        } on FirebaseException catch (firebaseError) {
          showFirebaseError(context, ref, error: firebaseError);
        } catch (error) {
          showFirebaseError(context, ref);
        }
      },
      builder: (context, controller) => Section(
        itemSpacing: 14,
        children: [
          AnimatedHider(
            visible: profile?.verified == false,
            child: const Padding(
              padding: EdgeInsets.only(bottom: 22.0),
              child: VerfiedMailCard(),
            ),
          ),
          EmailAddressField(
            controller,
            storedEmailAddress: profile?.email,
            showChangeNotice: controller.inputs["email"]?.dirty ?? false,
            showChangeEmailSent: sentChangeEmail.value,
          ),
          NameField(
            controller,
            storedName: profile?.name,
          ),
          PhoneNumberField(
            controller,
            storedPhoneNumber: profile?.phone,
          ),
          LanguageField(
            controller,
            storedLanguage: profile?.language,
          ),
          if (enabledAuths.password) const PasswordChangeButton(),
          const AccountButtons(
            canDeleteAccount: false,
          )
        ],
      ),
    );
  }
}
