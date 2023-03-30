/// Generated file. Do not edit.
///
/// Locales: 4
/// Strings: 488 (122 per locale)
///
/// Built on 2023-03-24 at 12:42 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, TranslationsEn> {
	en(languageCode: 'en', build: TranslationsEn.build),
	de(languageCode: 'de', build: TranslationsDe.build),
	fr(languageCode: 'fr', build: TranslationsFr.build),
	nl(languageCode: 'nl', build: TranslationsNl.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, TranslationsEn> build;
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, TranslationsEn> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class TranslationsEn implements BaseTranslations<AppLocale, TranslationsEn> {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  );

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, TranslationsEn> $meta;

	late final TranslationsEn _root = this; // ignore: unused_field

	// Translations
	late final TranslationsFormsEn forms = TranslationsFormsEn._(_root);
	late final TranslationsProfileEn profile = TranslationsProfileEn._(_root);
	late final TranslationsFirebaseErrorsEn firebaseErrors = TranslationsFirebaseErrorsEn._(_root);
	late final TranslationsScaffoldEn scaffold = TranslationsScaffoldEn._(_root);
	late final TranslationsLoginEn login = TranslationsLoginEn._(_root);
}

// Path: forms
class TranslationsFormsEn {
	TranslationsFormsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	late final TranslationsFormsButtonsEn buttons = TranslationsFormsButtonsEn._(_root);
	String get selectAnOption => 'Select an option';
	late final TranslationsFormsInputsEn inputs = TranslationsFormsInputsEn._(_root);
}

// Path: profile
class TranslationsProfileEn {
	TranslationsProfileEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get signOut => 'Sign out';
	late final TranslationsProfileMessagesEn messages = TranslationsProfileMessagesEn._(_root);
	late final TranslationsProfilePageEn page = TranslationsProfilePageEn._(_root);
	late final TranslationsProfileDeleteAccountEn deleteAccount = TranslationsProfileDeleteAccountEn._(_root);
	late final TranslationsProfileFieldsEn fields = TranslationsProfileFieldsEn._(_root);
	late final TranslationsProfileVerifyEmailCardEn verifyEmailCard = TranslationsProfileVerifyEmailCardEn._(_root);
}

// Path: firebaseErrors
class TranslationsFirebaseErrorsEn {
	TranslationsFirebaseErrorsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get unknown => 'Something went wrong. Please try again later.';
	late final TranslationsFirebaseErrorsHttpsEn https = TranslationsFirebaseErrorsHttpsEn._(_root);
	late final TranslationsFirebaseErrorsAuthEn auth = TranslationsFirebaseErrorsAuthEn._(_root);
}

// Path: scaffold
class TranslationsScaffoldEn {
	TranslationsScaffoldEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	late final TranslationsScaffoldGreetingsEn greetings = TranslationsScaffoldGreetingsEn._(_root);
	String get search => 'Search...';
	String get guest => 'Guest';
	late final TranslationsScaffoldFallbackPageEn fallbackPage = TranslationsScaffoldFallbackPageEn._(_root);
	late final TranslationsScaffoldButtonsEn buttons = TranslationsScaffoldButtonsEn._(_root);
	late final TranslationsScaffoldDialogsEn dialogs = TranslationsScaffoldDialogsEn._(_root);
}

// Path: login
class TranslationsLoginEn {
	TranslationsLoginEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	late final TranslationsLoginSignInWithEn signInWith = TranslationsLoginSignInWithEn._(_root);
	late final TranslationsLoginFieldsEn fields = TranslationsLoginFieldsEn._(_root);
	late final TranslationsLoginForgotPasswordEn forgotPassword = TranslationsLoginForgotPasswordEn._(_root);
	late final TranslationsLoginMagicLinkEn magicLink = TranslationsLoginMagicLinkEn._(_root);
	late final TranslationsLoginButtonsEn buttons = TranslationsLoginButtonsEn._(_root);
}

// Path: forms.buttons
class TranslationsFormsButtonsEn {
	TranslationsFormsButtonsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get save => 'Save Changes';
	String get undo => 'Undo Changes';
	String get create => 'Create';
}

// Path: forms.inputs
class TranslationsFormsInputsEn {
	TranslationsFormsInputsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	late final TranslationsFormsInputsListEn list = TranslationsFormsInputsListEn._(_root);
}

// Path: profile.messages
class TranslationsProfileMessagesEn {
	TranslationsProfileMessagesEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get passwordUpdated => 'Password updated successfully';
	String get passwordRemoved => 'Password removed successfully';
}

// Path: profile.page
class TranslationsProfilePageEn {
	TranslationsProfilePageEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get name => 'My Profile';
	String get description => 'Manage your account, login and personal details';
}

// Path: profile.deleteAccount
class TranslationsProfileDeleteAccountEn {
	TranslationsProfileDeleteAccountEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get button => 'Delete account';
	String get warning => 'Are you sure you want to delete your account? This action cannot be undone.';
}

// Path: profile.fields
class TranslationsProfileFieldsEn {
	TranslationsProfileFieldsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	late final TranslationsProfileFieldsNameEn name = TranslationsProfileFieldsNameEn._(_root);
	late final TranslationsProfileFieldsEmailEn email = TranslationsProfileFieldsEmailEn._(_root);
	late final TranslationsProfileFieldsPhoneEn phone = TranslationsProfileFieldsPhoneEn._(_root);
	late final TranslationsProfileFieldsLanguageEn language = TranslationsProfileFieldsLanguageEn._(_root);
}

// Path: profile.verifyEmailCard
class TranslationsProfileVerifyEmailCardEn {
	TranslationsProfileVerifyEmailCardEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'E-mail address verification';
	String get message => 'In order to use your account, you need to verify your email address. We have sent you an email with a verification link. Please click on the link to verify your email address. It may take a few minutes for the email to arrive. If you don\'t see the email, make sure to check your spam folder.';
	late final TranslationsProfileVerifyEmailCardMessagesEn messages = TranslationsProfileVerifyEmailCardMessagesEn._(_root);
	late final TranslationsProfileVerifyEmailCardButtonsEn buttons = TranslationsProfileVerifyEmailCardButtonsEn._(_root);
}

// Path: firebaseErrors.https
class TranslationsFirebaseErrorsHttpsEn {
	TranslationsFirebaseErrorsHttpsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get DeadlineExceeded => 'The operation timed out. Please try again later.';
	String get NotFound => 'Could not find what you were looking for. Please try again.';
	String get AlreadyExists => 'This already exists. Please try again with different detail",';
	String get PermissionDenied => 'You do not have permission to perform this action.';
	String get Unimplemented => 'This feature is not currently supported. Please check back later.",';
	String get Unavailable => 'The service is currently unavailable. Please try again later.';
	String get Unauthenticated => 'You are not authenticated. Please log in or provide valid credentials to continue.';
}

// Path: firebaseErrors.auth
class TranslationsFirebaseErrorsAuthEn {
	TranslationsFirebaseErrorsAuthEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get AdminRestrictedOperation => 'You are not authorized to perform this action.';
	String get ArgumentError => 'Something is wrong with the information you provided.';
	String get AppNotInstalled => 'Please install the app to continue.';
	String get CaptchaCheckFailed => 'Please verify that you are not a robot.';
	String get CodeExpired => 'The code you entered has expired. Please try again.';
	String get CredentialAlreadyInUse => 'The account is already in use by another user.';
	String get CustomTokenMismatch => 'There is a problem with your login credentials.';
	String get RequiresRecentLogin => 'You need to login again to complete this action.';
	String get DynamicLinkNotActivated => 'The link you are trying to access is no longer active.';
	String get EmailChangeNeedsVerification => 'You need to verify your new email address to complete this action.';
	String get EmailAlreadyInUse => 'This email is already associated with an account.';
	String get ExpiredActionCode => 'The code you entered has expired. Please try again.';
	String get CancelledPopupRequest => 'The popup request was cancelled.';
	String get InvalidVerificationCode => 'The verification code is invalid. Please try again.';
	String get InvalidEmail => 'The email address you entered is invalid. Please try again.';
	String get UnauthorizedDomain => 'You are not authorized to access this domain.';
	String get WrongPassword => 'The password you entered is incorrect. Please try again.';
	String get InvalidPhoneNumber => 'The phone number you entered is invalid. Please try again with a valid phone number.';
	String get InvalidRecipientEmail => 'The recipient email address is invalid. Please try again.';
	String get InvalidSender => 'The sender is invalid. Please try again.';
	String get MultiFactorAuthRequired => 'Multi-factor authentication is required to complete this.';
	String get AccountExistsWithDifferentCredential => 'An account already exists with this email address. Please try logging in with a different method.';
	String get NetworkRequestFailed => 'The network request failed. Please check your internet connection and try again.';
	String get OperationNotAllowed => 'You are not allowed to perform this operation.';
	String get PopupBlocked => 'The popup was blocked. Please allow popups and try again.';
	String get ProviderAlreadyLinked => 'The provider is already linked to another account. Please try again.';
	String get SecondFactorAlreadyInUse => 'The second factor is already in use. Please try again.';
	String get MaximumSecondFactorCountExceeded => 'The maximum number of second factors has been reached. Please try again.';
	String get Timeout => 'The operation timed out. Please try again.';
	String get TooManyRequests => 'Too many requests. Please try again later.';
	String get UnverifiedEmail => 'The email address has not been verified. Please check your email and follow the verification link.';
	String get UserNotFound => 'The user account was not found. Please try again.';
	String get UserDisabled => 'The user account has been disabled. Please contact support for assistance.';
	String get UserSignedOut => 'The user account has been signed out. Please log in again to continue.';
	String get WeakPassword => 'The password is too weak. Please choose a stronger password.';
}

// Path: scaffold.greetings
class TranslationsScaffoldGreetingsEn {
	TranslationsScaffoldGreetingsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get morning => 'Good morning';
	String get afternoon => 'Good afternoon';
	String get evening => 'Good evening';
	String get night => 'Good night';
}

// Path: scaffold.fallbackPage
class TranslationsScaffoldFallbackPageEn {
	TranslationsScaffoldFallbackPageEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Page not found';
	String get message => 'The page you are looking for does not exist.';
}

// Path: scaffold.buttons
class TranslationsScaffoldButtonsEn {
	TranslationsScaffoldButtonsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get goToSignIn => 'Go to sign in';
}

// Path: scaffold.dialogs
class TranslationsScaffoldDialogsEn {
	TranslationsScaffoldDialogsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get confirm => 'Confirm';
}

// Path: login.signInWith
class TranslationsLoginSignInWithEn {
	TranslationsLoginSignInWithEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get password => 'Sign in with password';
	String get magicLink => 'Sign in with magic link';
	String get google => 'Sign in with Google';
	String get apple => 'Sign in with Apple';
}

// Path: login.fields
class TranslationsLoginFieldsEn {
	TranslationsLoginFieldsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	late final TranslationsLoginFieldsEmailEn email = TranslationsLoginFieldsEmailEn._(_root);
	late final TranslationsLoginFieldsPasswordEn password = TranslationsLoginFieldsPasswordEn._(_root);
}

// Path: login.forgotPassword
class TranslationsLoginForgotPasswordEn {
	TranslationsLoginForgotPasswordEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	late final TranslationsLoginForgotPasswordButtonsEn buttons = TranslationsLoginForgotPasswordButtonsEn._(_root);
	late final TranslationsLoginForgotPasswordSentEn sent = TranslationsLoginForgotPasswordSentEn._(_root);
	late final TranslationsLoginForgotPasswordDialogEn dialog = TranslationsLoginForgotPasswordDialogEn._(_root);
}

// Path: login.magicLink
class TranslationsLoginMagicLinkEn {
	TranslationsLoginMagicLinkEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	late final TranslationsLoginMagicLinkSentEn sent = TranslationsLoginMagicLinkSentEn._(_root);
	late final TranslationsLoginMagicLinkButtonsEn buttons = TranslationsLoginMagicLinkButtonsEn._(_root);
}

// Path: login.buttons
class TranslationsLoginButtonsEn {
	TranslationsLoginButtonsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get back => 'Back to login';
	String get signin => 'Sign in';
}

// Path: forms.inputs.list
class TranslationsFormsInputsListEn {
	TranslationsFormsInputsListEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get add => 'Add';
}

// Path: profile.fields.name
class TranslationsProfileFieldsNameEn {
	TranslationsProfileFieldsNameEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get label => 'Name';
	String get enter => 'Enter your name';
	String get required => 'Name is required';
}

// Path: profile.fields.email
class TranslationsProfileFieldsEmailEn {
	TranslationsProfileFieldsEmailEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get label => 'E-mail address';
	String get enter => 'Enter your e-mail address';
	String get required => 'E-mail address is required';
	String get invalid => 'E-mail address is invalid';
	late final TranslationsProfileFieldsEmailNoticesEn notices = TranslationsProfileFieldsEmailNoticesEn._(_root);
}

// Path: profile.fields.phone
class TranslationsProfileFieldsPhoneEn {
	TranslationsProfileFieldsPhoneEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get label => 'Phone number';
	String get enter => 'Enter your phone number';
	String get required => 'Phone number is required';
	String get invalid => 'Phone number is invalid';
}

// Path: profile.fields.language
class TranslationsProfileFieldsLanguageEn {
	TranslationsProfileFieldsLanguageEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get label => 'Language';
	String get select => 'Select your language';
}

// Path: profile.verifyEmailCard.messages
class TranslationsProfileVerifyEmailCardMessagesEn {
	TranslationsProfileVerifyEmailCardMessagesEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get sent => 'Verification e-mail sent';
}

// Path: profile.verifyEmailCard.buttons
class TranslationsProfileVerifyEmailCardButtonsEn {
	TranslationsProfileVerifyEmailCardButtonsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get resend => 'Resend verification e-mail';
	String get back => 'Back to login';
	String get inbox => 'Go to inbox';
}

// Path: login.fields.email
class TranslationsLoginFieldsEmailEn {
	TranslationsLoginFieldsEmailEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get label => 'E-mail address';
	String get enter => 'Enter your e-mail address';
	String get required => 'E-mail address is required';
}

// Path: login.fields.password
class TranslationsLoginFieldsPasswordEn {
	TranslationsLoginFieldsPasswordEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get label => 'Password';
	String get enter => 'Enter your password';
	String get required => 'Password is required';
}

// Path: login.forgotPassword.buttons
class TranslationsLoginForgotPasswordButtonsEn {
	TranslationsLoginForgotPasswordButtonsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get forgot => 'Forgot password?';
	String get sendLink => 'Send password reset link';
	String get inbox => 'Go to inbox';
}

// Path: login.forgotPassword.sent
class TranslationsLoginForgotPasswordSentEn {
	TranslationsLoginForgotPasswordSentEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Password reset link sent';
	String get message => 'A password reset link has been sent to your e-mail address. Please check your inbox and follow the link to continue. If you did not receive the e-mail, please check your spam folder. Please keep in mind that it may take a few minutes for the e-mail to arrive, though it is usually a couple of seconds.';
}

// Path: login.forgotPassword.dialog
class TranslationsLoginForgotPasswordDialogEn {
	TranslationsLoginForgotPasswordDialogEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Reset password';
	String get message => 'Please enter your new password and repeat it to confirm, then click the button below.';
	late final TranslationsLoginForgotPasswordDialogFieldsEn fields = TranslationsLoginForgotPasswordDialogFieldsEn._(_root);
	late final TranslationsLoginForgotPasswordDialogButtonsEn buttons = TranslationsLoginForgotPasswordDialogButtonsEn._(_root);
	late final TranslationsLoginForgotPasswordDialogPopupsEn popups = TranslationsLoginForgotPasswordDialogPopupsEn._(_root);
}

// Path: login.magicLink.sent
class TranslationsLoginMagicLinkSentEn {
	TranslationsLoginMagicLinkSentEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Magic link sent';
	String get message => 'A magic link has been sent to your e-mail address. Please check your inbox and follow the link to continue. If you did not receive the e-mail, please check your spam folder. Please keep in mind that it may take a few minutes for the e-mail to arrive, though it is usually a couple of seconds.';
}

// Path: login.magicLink.buttons
class TranslationsLoginMagicLinkButtonsEn {
	TranslationsLoginMagicLinkButtonsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get send => 'Send magic link';
	String get back => 'Back to login';
	String get inbox => 'Go to inbox';
}

// Path: profile.fields.email.notices
class TranslationsProfileFieldsEmailNoticesEn {
	TranslationsProfileFieldsEmailNoticesEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get change => 'Please note that any changes made to your e-mail address will not be applied until you click the verify button in the mail we send to your old e-mail address.';
	String get changeSent => 'Please verify your new e-mail by clicking the verification link we sent to your old e-mail. It may take a few minutes for the e-mail to arrive. If you don\'t see it, check your spam folder.';
}

// Path: login.forgotPassword.dialog.fields
class TranslationsLoginForgotPasswordDialogFieldsEn {
	TranslationsLoginForgotPasswordDialogFieldsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	late final TranslationsLoginForgotPasswordDialogFieldsNewPasswordEn newPassword = TranslationsLoginForgotPasswordDialogFieldsNewPasswordEn._(_root);
	late final TranslationsLoginForgotPasswordDialogFieldsConfirmPasswordEn confirmPassword = TranslationsLoginForgotPasswordDialogFieldsConfirmPasswordEn._(_root);
}

// Path: login.forgotPassword.dialog.buttons
class TranslationsLoginForgotPasswordDialogButtonsEn {
	TranslationsLoginForgotPasswordDialogButtonsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get update => 'Update password';
}

// Path: login.forgotPassword.dialog.popups
class TranslationsLoginForgotPasswordDialogPopupsEn {
	TranslationsLoginForgotPasswordDialogPopupsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get passwordMismatch => 'The passwords you entered do not match. Please re-enter your password.';
	String get codeExpired => 'The password reset code has expired. Please go back to login and resend the password reset link.';
	String get updateSuccess => 'Your password has been updated. Please log in with your new password.';
}

// Path: login.forgotPassword.dialog.fields.newPassword
class TranslationsLoginForgotPasswordDialogFieldsNewPasswordEn {
	TranslationsLoginForgotPasswordDialogFieldsNewPasswordEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get label => 'New password';
	String get enter => 'Enter your new password';
	String get required => 'New password is required';
	String get short => 'New password is too short';
}

// Path: login.forgotPassword.dialog.fields.confirmPassword
class TranslationsLoginForgotPasswordDialogFieldsConfirmPasswordEn {
	TranslationsLoginForgotPasswordDialogFieldsConfirmPasswordEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get label => 'Confirm password';
	String get enter => 'Confirm your new password';
	String get required => 'Confirm password is required';
	String get mismatch => 'Passwords do not match';
}

// Path: <root>
class TranslationsDe extends TranslationsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super.build(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	/// Metadata for the translations of <de>.
	@override final TranslationMetadata<AppLocale, TranslationsEn> $meta;

	@override late final TranslationsDe _root = this; // ignore: unused_field

	// Translations
	@override late final TranslationsFormsDe forms = TranslationsFormsDe._(_root);
	@override late final TranslationsProfileDe profile = TranslationsProfileDe._(_root);
	@override late final TranslationsFirebaseErrorsDe firebaseErrors = TranslationsFirebaseErrorsDe._(_root);
	@override late final TranslationsScaffoldDe scaffold = TranslationsScaffoldDe._(_root);
	@override late final TranslationsLoginDe login = TranslationsLoginDe._(_root);
}

// Path: forms
class TranslationsFormsDe extends TranslationsFormsEn {
	TranslationsFormsDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final TranslationsFormsButtonsDe buttons = TranslationsFormsButtonsDe._(_root);
	@override String get selectAnOption => 'Wählen Sie eine Option aus';
	@override late final TranslationsFormsInputsDe inputs = TranslationsFormsInputsDe._(_root);
}

// Path: profile
class TranslationsProfileDe extends TranslationsProfileEn {
	TranslationsProfileDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get signOut => 'Abmelden';
	@override late final TranslationsProfileMessagesDe messages = TranslationsProfileMessagesDe._(_root);
	@override late final TranslationsProfilePageDe page = TranslationsProfilePageDe._(_root);
	@override late final TranslationsProfileDeleteAccountDe deleteAccount = TranslationsProfileDeleteAccountDe._(_root);
	@override late final TranslationsProfileFieldsDe fields = TranslationsProfileFieldsDe._(_root);
	@override late final TranslationsProfileVerifyEmailCardDe verifyEmailCard = TranslationsProfileVerifyEmailCardDe._(_root);
}

// Path: firebaseErrors
class TranslationsFirebaseErrorsDe extends TranslationsFirebaseErrorsEn {
	TranslationsFirebaseErrorsDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get unknown => 'Etwas ist schief gelaufen. Bitte versuchen Sie es später noch einmal.';
	@override late final TranslationsFirebaseErrorsHttpsDe https = TranslationsFirebaseErrorsHttpsDe._(_root);
	@override late final TranslationsFirebaseErrorsAuthDe auth = TranslationsFirebaseErrorsAuthDe._(_root);
}

// Path: scaffold
class TranslationsScaffoldDe extends TranslationsScaffoldEn {
	TranslationsScaffoldDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final TranslationsScaffoldGreetingsDe greetings = TranslationsScaffoldGreetingsDe._(_root);
	@override String get search => 'Suche...';
	@override String get guest => 'Gast';
	@override late final TranslationsScaffoldFallbackPageDe fallbackPage = TranslationsScaffoldFallbackPageDe._(_root);
	@override late final TranslationsScaffoldButtonsDe buttons = TranslationsScaffoldButtonsDe._(_root);
	@override late final TranslationsScaffoldDialogsDe dialogs = TranslationsScaffoldDialogsDe._(_root);
}

// Path: login
class TranslationsLoginDe extends TranslationsLoginEn {
	TranslationsLoginDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final TranslationsLoginSignInWithDe signInWith = TranslationsLoginSignInWithDe._(_root);
	@override late final TranslationsLoginFieldsDe fields = TranslationsLoginFieldsDe._(_root);
	@override late final TranslationsLoginForgotPasswordDe forgotPassword = TranslationsLoginForgotPasswordDe._(_root);
	@override late final TranslationsLoginMagicLinkDe magicLink = TranslationsLoginMagicLinkDe._(_root);
	@override late final TranslationsLoginButtonsDe buttons = TranslationsLoginButtonsDe._(_root);
}

// Path: forms.buttons
class TranslationsFormsButtonsDe extends TranslationsFormsButtonsEn {
	TranslationsFormsButtonsDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get save => 'Änderungen speichern';
	@override String get undo => 'Änderungen rückgängig machen';
	@override String get create => 'Erstellen';
}

// Path: forms.inputs
class TranslationsFormsInputsDe extends TranslationsFormsInputsEn {
	TranslationsFormsInputsDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final TranslationsFormsInputsListDe list = TranslationsFormsInputsListDe._(_root);
}

// Path: profile.messages
class TranslationsProfileMessagesDe extends TranslationsProfileMessagesEn {
	TranslationsProfileMessagesDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get passwordUpdated => 'Passwort erfolgreich aktualisiert';
	@override String get passwordRemoved => 'Passwort erfolgreich entfernt';
}

// Path: profile.page
class TranslationsProfilePageDe extends TranslationsProfilePageEn {
	TranslationsProfilePageDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Mein Profil';
	@override String get description => 'Verwalten Sie Ihr Konto, melden Sie sich an und verwalten Sie Ihre persönlichen Daten.';
}

// Path: profile.deleteAccount
class TranslationsProfileDeleteAccountDe extends TranslationsProfileDeleteAccountEn {
	TranslationsProfileDeleteAccountDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get button => 'Konto löschen';
	@override String get warning => 'Sind Sie sicher, dass Sie Ihr Konto löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.';
}

// Path: profile.fields
class TranslationsProfileFieldsDe extends TranslationsProfileFieldsEn {
	TranslationsProfileFieldsDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final TranslationsProfileFieldsNameDe name = TranslationsProfileFieldsNameDe._(_root);
	@override late final TranslationsProfileFieldsEmailDe email = TranslationsProfileFieldsEmailDe._(_root);
	@override late final TranslationsProfileFieldsPhoneDe phone = TranslationsProfileFieldsPhoneDe._(_root);
	@override late final TranslationsProfileFieldsLanguageDe language = TranslationsProfileFieldsLanguageDe._(_root);
}

// Path: profile.verifyEmailCard
class TranslationsProfileVerifyEmailCardDe extends TranslationsProfileVerifyEmailCardEn {
	TranslationsProfileVerifyEmailCardDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'E-Mail-Adresse bestätigen';
	@override String get message => 'Um Ihr Konto nutzen zu können, müssen Sie Ihre E-Mail-Adresse bestätigen. Wir haben Ihnen eine E-Mail mit einem Bestätigungslink gesendet. Bitte klicken Sie auf den Link, um Ihre E-Mail-Adresse zu bestätigen. Es kann einige Minuten dauern, bis die E-Mail eintrifft. Wenn Sie die E-Mail nicht sehen, überprüfen Sie bitte Ihren Spam-Ordner.';
	@override late final TranslationsProfileVerifyEmailCardMessagesDe messages = TranslationsProfileVerifyEmailCardMessagesDe._(_root);
	@override late final TranslationsProfileVerifyEmailCardButtonsDe buttons = TranslationsProfileVerifyEmailCardButtonsDe._(_root);
}

// Path: firebaseErrors.https
class TranslationsFirebaseErrorsHttpsDe extends TranslationsFirebaseErrorsHttpsEn {
	TranslationsFirebaseErrorsHttpsDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get DeadlineExceeded => 'Der Vorgang ist abgelaufen. Bitte versuchen Sie es später noch einmal.';
	@override String get NotFound => 'Wir konnten nicht finden, wonach Sie gesucht haben. Bitte versuchen Sie es erneut.';
	@override String get AlreadyExists => 'Dies existiert bereits. Bitte versuchen Sie es mit anderen Details erneut.';
	@override String get PermissionDenied => 'Sie haben keine Berechtigung, diese Aktion durchzuführen.';
	@override String get Unimplemented => 'Diese Funktion wird derzeit nicht unterstützt. Bitte versuchen Sie es später erneut.';
	@override String get Unavailable => 'Der Dienst ist derzeit nicht verfügbar. Bitte versuchen Sie es später noch einmal.';
	@override String get Unauthenticated => 'Sie sind nicht authentifiziert. Bitte melden Sie sich an oder geben Sie gültige Anmeldeinformationen an, um fortzufahren.';
}

// Path: firebaseErrors.auth
class TranslationsFirebaseErrorsAuthDe extends TranslationsFirebaseErrorsAuthEn {
	TranslationsFirebaseErrorsAuthDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get AdminRestrictedOperation => 'Sie sind nicht berechtigt, diese Aktion durchzuführen.';
	@override String get ArgumentError => 'Etwas stimmt nicht mit den von Ihnen angegebenen Informationen.';
	@override String get AppNotInstalled => 'Bitte installieren Sie die App, um fortzufahren.';
	@override String get CaptchaCheckFailed => 'Bitte bestätigen Sie, dass Sie kein Roboter sind.';
	@override String get CodeExpired => 'Der eingegebene Code ist abgelaufen. Bitte versuchen Sie es erneut.';
	@override String get CredentialAlreadyInUse => 'Das Konto wird bereits von einem anderen Benutzer verwendet.';
	@override String get CustomTokenMismatch => 'Es gibt ein Problem mit Ihren Anmeldeinformationen.';
	@override String get RequiresRecentLogin => 'Sie müssen sich erneut anmelden, um diese Aktion abzuschließen.';
	@override String get DynamicLinkNotActivated => 'Der Link, auf den Sie zugreifen möchten, ist nicht mehr aktiv.';
	@override String get EmailChangeNeedsVerification => 'Sie müssen Ihre neue E-Mail-Adresse bestätigen, um diese Aktion abzuschließen.';
	@override String get EmailAlreadyInUse => 'Diese E-Mail ist bereits mit einem Konto verknüpft.';
	@override String get ExpiredActionCode => 'Der eingegebene Code ist abgelaufen. Bitte versuchen Sie es erneut.';
	@override String get CancelledPopupRequest => 'Die Popup-Anfrage wurde abgebrochen.';
	@override String get InvalidVerificationCode => 'Der Bestätigungscode ist ungültig. Bitte versuchen Sie es erneut.';
	@override String get InvalidEmail => 'Die eingegebene E-Mail-Adresse ist ungültig. Bitte versuchen Sie es erneut.';
	@override String get UnauthorizedDomain => 'Sie sind nicht berechtigt, auf diesen Bereich zuzugreifen.';
	@override String get WrongPassword => 'Das eingegebene Passwort ist falsch. Bitte versuchen Sie es erneut.';
	@override String get InvalidPhoneNumber => 'Die eingegebene Telefonnummer ist ungültig. Bitte versuchen Sie es erneut mit einer gültigen Telefonnummer.';
	@override String get InvalidRecipientEmail => 'Die E-Mail-Adresse des Empfängers ist ungültig. Bitte versuchen Sie es erneut.';
	@override String get InvalidSender => 'Der Absender ist ungültig. Bitte versuchen Sie es erneut.';
	@override String get MultiFactorAuthRequired => 'Mehrfaktorauthentifizierung ist erforderlich, um dies abzuschließen.';
	@override String get AccountExistsWithDifferentCredential => 'Ein Konto existiert bereits mit dieser E-Mail-Adresse. Bitte versuchen Sie, sich mit einer anderen Methode anzumelden.';
	@override String get NetworkRequestFailed => 'Die Netzwerkanfrage ist fehlgeschlagen. Bitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.';
	@override String get OperationNotAllowed => 'Sie dürfen diesen Vorgang nicht ausführen.';
	@override String get PopupBlocked => 'Das Popup wurde blockiert. Bitte erlauben Sie Popups und versuchen Sie es erneut.';
	@override String get ProviderAlreadyLinked => 'Der Anbieter ist bereits mit einem anderen Konto verknüpft. Bitte versuchen Sie es erneut.';
	@override String get SecondFactorAlreadyInUse => 'Der zweite Faktor ist bereits in Gebrauch. Bitte versuchen Sie es erneut.';
	@override String get MaximumSecondFactorCountExceeded => 'Die maximale Anzahl an zweiten Faktoren wurde erreicht. Bitte versuchen Sie es erneut.';
	@override String get Timeout => 'Der Vorgang ist abgelaufen. Bitte versuchen Sie es erneut.';
	@override String get TooManyRequests => 'Zu viele Anfragen. Bitte versuchen Sie es später erneut.';
	@override String get UnverifiedEmail => 'Die E-Mail-Adresse wurde nicht bestätigt. Bitte überprüfen Sie Ihre E-Mail und folgen Sie dem Bestätigungslink.';
	@override String get UserNotFound => 'Das Benutzerkonto wurde nicht gefunden. Bitte versuchen Sie es erneut.';
	@override String get UserDisabled => 'Das Benutzerkonto wurde deaktiviert. Bitte wenden Sie sich an den Support, um Hilfe zu erhalten.';
	@override String get UserSignedOut => 'Das Benutzerkonto wurde abgemeldet. Bitte melden Sie sich erneut an, um fortzufahren.';
	@override String get WeakPassword => 'Das Passwort ist zu schwach. Bitte wählen Sie ein stärkeres Passwort.';
}

// Path: scaffold.greetings
class TranslationsScaffoldGreetingsDe extends TranslationsScaffoldGreetingsEn {
	TranslationsScaffoldGreetingsDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get morning => 'Guten Morgen';
	@override String get afternoon => 'Guten Tag';
	@override String get evening => 'Guten Abend';
	@override String get night => 'Gute Nacht';
}

// Path: scaffold.fallbackPage
class TranslationsScaffoldFallbackPageDe extends TranslationsScaffoldFallbackPageEn {
	TranslationsScaffoldFallbackPageDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seite nicht gefunden';
	@override String get message => 'Die von Ihnen gesuchte Seite existiert nicht.';
}

// Path: scaffold.buttons
class TranslationsScaffoldButtonsDe extends TranslationsScaffoldButtonsEn {
	TranslationsScaffoldButtonsDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get goToSignIn => 'Zur Anmeldung gehen';
}

// Path: scaffold.dialogs
class TranslationsScaffoldDialogsDe extends TranslationsScaffoldDialogsEn {
	TranslationsScaffoldDialogsDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get confirm => 'Bestätigen';
}

// Path: login.signInWith
class TranslationsLoginSignInWithDe extends TranslationsLoginSignInWithEn {
	TranslationsLoginSignInWithDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get password => 'Mit Passwort anmelden';
	@override String get magicLink => 'Mit Magic Link anmelden';
	@override String get google => 'Mit Google anmelden';
	@override String get apple => 'Mit Apple anmelden';
}

// Path: login.fields
class TranslationsLoginFieldsDe extends TranslationsLoginFieldsEn {
	TranslationsLoginFieldsDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final TranslationsLoginFieldsEmailDe email = TranslationsLoginFieldsEmailDe._(_root);
	@override late final TranslationsLoginFieldsPasswordDe password = TranslationsLoginFieldsPasswordDe._(_root);
}

// Path: login.forgotPassword
class TranslationsLoginForgotPasswordDe extends TranslationsLoginForgotPasswordEn {
	TranslationsLoginForgotPasswordDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final TranslationsLoginForgotPasswordButtonsDe buttons = TranslationsLoginForgotPasswordButtonsDe._(_root);
	@override late final TranslationsLoginForgotPasswordSentDe sent = TranslationsLoginForgotPasswordSentDe._(_root);
	@override late final TranslationsLoginForgotPasswordDialogDe dialog = TranslationsLoginForgotPasswordDialogDe._(_root);
}

// Path: login.magicLink
class TranslationsLoginMagicLinkDe extends TranslationsLoginMagicLinkEn {
	TranslationsLoginMagicLinkDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final TranslationsLoginMagicLinkSentDe sent = TranslationsLoginMagicLinkSentDe._(_root);
	@override late final TranslationsLoginMagicLinkButtonsDe buttons = TranslationsLoginMagicLinkButtonsDe._(_root);
}

// Path: login.buttons
class TranslationsLoginButtonsDe extends TranslationsLoginButtonsEn {
	TranslationsLoginButtonsDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get back => 'Zurück zur Anmeldung';
	@override String get signin => 'Anmelden';
}

// Path: forms.inputs.list
class TranslationsFormsInputsListDe extends TranslationsFormsInputsListEn {
	TranslationsFormsInputsListDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get add => 'Hinzufügen';
}

// Path: profile.fields.name
class TranslationsProfileFieldsNameDe extends TranslationsProfileFieldsNameEn {
	TranslationsProfileFieldsNameDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'Name';
	@override String get enter => 'Geben Sie Ihren Namen ein';
	@override String get required => 'Name ist erforderlich';
}

// Path: profile.fields.email
class TranslationsProfileFieldsEmailDe extends TranslationsProfileFieldsEmailEn {
	TranslationsProfileFieldsEmailDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'E-Mail-Adresse';
	@override String get enter => 'Geben Sie Ihre E-Mail-Adresse ein';
	@override String get required => 'E-Mail-Adresse ist erforderlich';
	@override String get invalid => 'E-Mail-Adresse ist ungültig';
	@override late final TranslationsProfileFieldsEmailNoticesDe notices = TranslationsProfileFieldsEmailNoticesDe._(_root);
}

// Path: profile.fields.phone
class TranslationsProfileFieldsPhoneDe extends TranslationsProfileFieldsPhoneEn {
	TranslationsProfileFieldsPhoneDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'Telefonnummer';
	@override String get enter => 'Geben Sie Ihre Telefonnummer ein';
	@override String get required => 'Telefonnummer ist erforderlich';
	@override String get invalid => 'Telefonnummer ist ungültig';
}

// Path: profile.fields.language
class TranslationsProfileFieldsLanguageDe extends TranslationsProfileFieldsLanguageEn {
	TranslationsProfileFieldsLanguageDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'Sprache';
	@override String get select => 'Wählen Sie Ihre Sprache aus';
}

// Path: profile.verifyEmailCard.messages
class TranslationsProfileVerifyEmailCardMessagesDe extends TranslationsProfileVerifyEmailCardMessagesEn {
	TranslationsProfileVerifyEmailCardMessagesDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get sent => 'Bestätigungs-E-Mail gesendet';
}

// Path: profile.verifyEmailCard.buttons
class TranslationsProfileVerifyEmailCardButtonsDe extends TranslationsProfileVerifyEmailCardButtonsEn {
	TranslationsProfileVerifyEmailCardButtonsDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get resend => 'Bestätigungs-E-Mail erneut senden';
	@override String get back => 'Zurück zur Anmeldung';
	@override String get inbox => 'Zur Posteingangsübersicht';
}

// Path: login.fields.email
class TranslationsLoginFieldsEmailDe extends TranslationsLoginFieldsEmailEn {
	TranslationsLoginFieldsEmailDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'E-Mail-Adresse';
	@override String get enter => 'Geben Sie Ihre E-Mail-Adresse ein';
	@override String get required => 'E-Mail-Adresse ist erforderlich';
}

// Path: login.fields.password
class TranslationsLoginFieldsPasswordDe extends TranslationsLoginFieldsPasswordEn {
	TranslationsLoginFieldsPasswordDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'Passwort';
	@override String get enter => 'Geben Sie Ihr Passwort ein';
	@override String get required => 'Passwort ist erforderlich';
}

// Path: login.forgotPassword.buttons
class TranslationsLoginForgotPasswordButtonsDe extends TranslationsLoginForgotPasswordButtonsEn {
	TranslationsLoginForgotPasswordButtonsDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get forgot => 'Passwort vergessen?';
	@override String get sendLink => 'Passwort-Reset-Link senden';
	@override String get inbox => 'Zum Posteingang gehen';
}

// Path: login.forgotPassword.sent
class TranslationsLoginForgotPasswordSentDe extends TranslationsLoginForgotPasswordSentEn {
	TranslationsLoginForgotPasswordSentDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Passwort-Reset-Link gesendet';
	@override String get message => 'Ein Passwort-Reset-Link wurde an Ihre E-Mail-Adresse gesendet. Bitte überprüfen Sie Ihren Posteingang und folgen Sie dem Link, um fortzufahren. Wenn Sie die E-Mail nicht erhalten haben, überprüfen Sie bitte Ihren Spam-Ordner. Bitte beachten Sie, dass es ein paar Minuten dauern kann, bis die E-Mail ankommt, obwohl es normalerweise nur wenige Sekunden sind.';
}

// Path: login.forgotPassword.dialog
class TranslationsLoginForgotPasswordDialogDe extends TranslationsLoginForgotPasswordDialogEn {
	TranslationsLoginForgotPasswordDialogDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Passwort zurücksetzen';
	@override String get message => 'Bitte geben Sie Ihr neues Passwort ein und bestätigen Sie es erneut, bevor Sie unten auf die Schaltfläche klicken.';
	@override late final TranslationsLoginForgotPasswordDialogFieldsDe fields = TranslationsLoginForgotPasswordDialogFieldsDe._(_root);
	@override late final TranslationsLoginForgotPasswordDialogButtonsDe buttons = TranslationsLoginForgotPasswordDialogButtonsDe._(_root);
	@override late final TranslationsLoginForgotPasswordDialogPopupsDe popups = TranslationsLoginForgotPasswordDialogPopupsDe._(_root);
}

// Path: login.magicLink.sent
class TranslationsLoginMagicLinkSentDe extends TranslationsLoginMagicLinkSentEn {
	TranslationsLoginMagicLinkSentDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Magic Link gesendet';
	@override String get message => 'Ein Magic Link wurde an Ihre E-Mail-Adresse gesendet. Bitte überprüfen Sie Ihren Posteingang und folgen Sie dem Link, um fortzufahren. Wenn Sie die E-Mail nicht erhalten haben, überprüfen Sie bitte Ihren Spam-Ordner. Bitte beachten Sie, dass es ein paar Minuten dauern kann, bis die E-Mail ankommt, obwohl es normalerweise nur wenige Sekunden sind.';
}

// Path: login.magicLink.buttons
class TranslationsLoginMagicLinkButtonsDe extends TranslationsLoginMagicLinkButtonsEn {
	TranslationsLoginMagicLinkButtonsDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get send => 'Magic Link senden';
	@override String get back => 'Zurück zur Anmeldung';
	@override String get inbox => 'Zum Posteingang gehen';
}

// Path: profile.fields.email.notices
class TranslationsProfileFieldsEmailNoticesDe extends TranslationsProfileFieldsEmailNoticesEn {
	TranslationsProfileFieldsEmailNoticesDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get change => 'Bitte beachten Sie, dass Änderungen an Ihrer E-Mail-Adresse erst angewendet werden, nachdem Sie auf die Verifikationsschaltfläche in der E-Mail geklickt haben, die wir an Ihre alte E-Mail-Adresse senden.';
	@override String get changeSent => 'Bitte bestätigen Sie Ihre neue E-Mail-Adresse, indem Sie auf den Verifikationslink klicken, den wir an Ihre alte E-Mail-Adresse gesendet haben. Es kann einige Minuten dauern, bis die E-Mail eintrifft. Wenn Sie sie nicht sehen, überprüfen Sie Ihren Spam-Ordner.';
}

// Path: login.forgotPassword.dialog.fields
class TranslationsLoginForgotPasswordDialogFieldsDe extends TranslationsLoginForgotPasswordDialogFieldsEn {
	TranslationsLoginForgotPasswordDialogFieldsDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final TranslationsLoginForgotPasswordDialogFieldsNewPasswordDe newPassword = TranslationsLoginForgotPasswordDialogFieldsNewPasswordDe._(_root);
	@override late final TranslationsLoginForgotPasswordDialogFieldsConfirmPasswordDe confirmPassword = TranslationsLoginForgotPasswordDialogFieldsConfirmPasswordDe._(_root);
}

// Path: login.forgotPassword.dialog.buttons
class TranslationsLoginForgotPasswordDialogButtonsDe extends TranslationsLoginForgotPasswordDialogButtonsEn {
	TranslationsLoginForgotPasswordDialogButtonsDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get update => 'Passwort aktualisieren';
}

// Path: login.forgotPassword.dialog.popups
class TranslationsLoginForgotPasswordDialogPopupsDe extends TranslationsLoginForgotPasswordDialogPopupsEn {
	TranslationsLoginForgotPasswordDialogPopupsDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get passwordMismatch => 'Die von Ihnen eingegebenen Passwörter stimmen nicht überein. Bitte geben Sie Ihr Passwort erneut ein.';
	@override String get codeExpired => 'Der Passwort-Reset-Code ist abgelaufen. Bitte gehen Sie zurück zur Anmeldung und senden Sie erneut den Passwort-Reset-Link.';
	@override String get updateSuccess => 'Ihr Passwort wurde aktualisiert. Bitte melden Sie sich mit Ihrem neuen Passwort an.';
}

// Path: login.forgotPassword.dialog.fields.newPassword
class TranslationsLoginForgotPasswordDialogFieldsNewPasswordDe extends TranslationsLoginForgotPasswordDialogFieldsNewPasswordEn {
	TranslationsLoginForgotPasswordDialogFieldsNewPasswordDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'Neues Passwort';
	@override String get enter => 'Geben Sie Ihr neues Passwort ein';
	@override String get required => 'Neues Passwort ist erforderlich';
	@override String get short => 'Neues Passwort ist zu kurz';
}

// Path: login.forgotPassword.dialog.fields.confirmPassword
class TranslationsLoginForgotPasswordDialogFieldsConfirmPasswordDe extends TranslationsLoginForgotPasswordDialogFieldsConfirmPasswordEn {
	TranslationsLoginForgotPasswordDialogFieldsConfirmPasswordDe._(TranslationsDe root) : this._root = root, super._(root);

	@override final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'Passwort bestätigen';
	@override String get enter => 'Bestätigen Sie Ihr neues Passwort';
	@override String get required => 'Passwortbestätigung ist erforderlich';
	@override String get mismatch => 'Passwörter stimmen nicht überein';
}

// Path: <root>
class TranslationsFr extends TranslationsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super.build(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, TranslationsEn> $meta;

	@override late final TranslationsFr _root = this; // ignore: unused_field

	// Translations
	@override late final TranslationsFormsFr forms = TranslationsFormsFr._(_root);
	@override late final TranslationsProfileFr profile = TranslationsProfileFr._(_root);
	@override late final TranslationsFirebaseErrorsFr firebaseErrors = TranslationsFirebaseErrorsFr._(_root);
	@override late final TranslationsScaffoldFr scaffold = TranslationsScaffoldFr._(_root);
	@override late final TranslationsLoginFr login = TranslationsLoginFr._(_root);
}

// Path: forms
class TranslationsFormsFr extends TranslationsFormsEn {
	TranslationsFormsFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final TranslationsFormsButtonsFr buttons = TranslationsFormsButtonsFr._(_root);
	@override String get selectAnOption => 'Sélectionner une option';
	@override late final TranslationsFormsInputsFr inputs = TranslationsFormsInputsFr._(_root);
}

// Path: profile
class TranslationsProfileFr extends TranslationsProfileEn {
	TranslationsProfileFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get signOut => 'Déconnexion';
	@override late final TranslationsProfileMessagesFr messages = TranslationsProfileMessagesFr._(_root);
	@override late final TranslationsProfilePageFr page = TranslationsProfilePageFr._(_root);
	@override late final TranslationsProfileDeleteAccountFr deleteAccount = TranslationsProfileDeleteAccountFr._(_root);
	@override late final TranslationsProfileFieldsFr fields = TranslationsProfileFieldsFr._(_root);
	@override late final TranslationsProfileVerifyEmailCardFr verifyEmailCard = TranslationsProfileVerifyEmailCardFr._(_root);
}

// Path: firebaseErrors
class TranslationsFirebaseErrorsFr extends TranslationsFirebaseErrorsEn {
	TranslationsFirebaseErrorsFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get unknown => 'Quelque chose s\'est mal passé. Veuillez réessayer plus tard.';
	@override late final TranslationsFirebaseErrorsHttpsFr https = TranslationsFirebaseErrorsHttpsFr._(_root);
	@override late final TranslationsFirebaseErrorsAuthFr auth = TranslationsFirebaseErrorsAuthFr._(_root);
}

// Path: scaffold
class TranslationsScaffoldFr extends TranslationsScaffoldEn {
	TranslationsScaffoldFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final TranslationsScaffoldGreetingsFr greetings = TranslationsScaffoldGreetingsFr._(_root);
	@override String get search => 'Recherche...';
	@override String get guest => 'Invité';
	@override late final TranslationsScaffoldFallbackPageFr fallbackPage = TranslationsScaffoldFallbackPageFr._(_root);
	@override late final TranslationsScaffoldButtonsFr buttons = TranslationsScaffoldButtonsFr._(_root);
	@override late final TranslationsScaffoldDialogsFr dialogs = TranslationsScaffoldDialogsFr._(_root);
}

// Path: login
class TranslationsLoginFr extends TranslationsLoginEn {
	TranslationsLoginFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final TranslationsLoginSignInWithFr signInWith = TranslationsLoginSignInWithFr._(_root);
	@override late final TranslationsLoginFieldsFr fields = TranslationsLoginFieldsFr._(_root);
	@override late final TranslationsLoginForgotPasswordFr forgotPassword = TranslationsLoginForgotPasswordFr._(_root);
	@override late final TranslationsLoginMagicLinkFr magicLink = TranslationsLoginMagicLinkFr._(_root);
	@override late final TranslationsLoginButtonsFr buttons = TranslationsLoginButtonsFr._(_root);
}

// Path: forms.buttons
class TranslationsFormsButtonsFr extends TranslationsFormsButtonsEn {
	TranslationsFormsButtonsFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get save => 'Enregistrer les modifications';
	@override String get undo => 'Annuler les modifications';
	@override String get create => 'Créer';
}

// Path: forms.inputs
class TranslationsFormsInputsFr extends TranslationsFormsInputsEn {
	TranslationsFormsInputsFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final TranslationsFormsInputsListFr list = TranslationsFormsInputsListFr._(_root);
}

// Path: profile.messages
class TranslationsProfileMessagesFr extends TranslationsProfileMessagesEn {
	TranslationsProfileMessagesFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get passwordUpdated => 'Mot de passe mis à jour avec succès';
	@override String get passwordRemoved => 'Mot de passe supprimé avec succès';
}

// Path: profile.page
class TranslationsProfilePageFr extends TranslationsProfilePageEn {
	TranslationsProfilePageFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'Mon profil';
	@override String get description => 'Gérez votre compte, connectez-vous et vos informations personnelles';
}

// Path: profile.deleteAccount
class TranslationsProfileDeleteAccountFr extends TranslationsProfileDeleteAccountEn {
	TranslationsProfileDeleteAccountFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get button => 'Supprimer le compte';
	@override String get warning => 'Êtes-vous sûr de vouloir supprimer votre compte? Cette action ne peut pas être annulée.';
}

// Path: profile.fields
class TranslationsProfileFieldsFr extends TranslationsProfileFieldsEn {
	TranslationsProfileFieldsFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final TranslationsProfileFieldsNameFr name = TranslationsProfileFieldsNameFr._(_root);
	@override late final TranslationsProfileFieldsEmailFr email = TranslationsProfileFieldsEmailFr._(_root);
	@override late final TranslationsProfileFieldsPhoneFr phone = TranslationsProfileFieldsPhoneFr._(_root);
	@override late final TranslationsProfileFieldsLanguageFr language = TranslationsProfileFieldsLanguageFr._(_root);
}

// Path: profile.verifyEmailCard
class TranslationsProfileVerifyEmailCardFr extends TranslationsProfileVerifyEmailCardEn {
	TranslationsProfileVerifyEmailCardFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vérification de l\'adresse e-mail';
	@override String get message => 'Pour utiliser votre compte, vous devez vérifier votre adresse e-mail. Nous vous avons envoyé un e-mail avec un lien de vérification. Veuillez cliquer sur le lien pour vérifier votre adresse e-mail. Il peut falloir quelques minutes pour que l\'e-mail arrive. Si vous ne voyez pas l\'e-mail, assurez-vous de vérifier votre dossier de courrier indésirable.';
	@override late final TranslationsProfileVerifyEmailCardMessagesFr messages = TranslationsProfileVerifyEmailCardMessagesFr._(_root);
	@override late final TranslationsProfileVerifyEmailCardButtonsFr buttons = TranslationsProfileVerifyEmailCardButtonsFr._(_root);
}

// Path: firebaseErrors.https
class TranslationsFirebaseErrorsHttpsFr extends TranslationsFirebaseErrorsHttpsEn {
	TranslationsFirebaseErrorsHttpsFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get DeadlineExceeded => 'L\'opération a expiré. Veuillez réessayer plus tard.';
	@override String get NotFound => 'Nous n\'avons pas trouvé ce que vous cherchiez. Veuillez réessayer.';
	@override String get AlreadyExists => 'Cela existe déjà. Veuillez réessayer avec d\'autres détails.';
	@override String get PermissionDenied => 'Vous n\'avez pas la permission d\'effectuer cette action.';
	@override String get Unimplemented => 'Cette fonctionnalité n\'est pas encore prise en charge. Veuillez revenir plus tard.';
	@override String get Unavailable => 'Le service est actuellement indisponible. Veuillez réessayer plus tard.';
	@override String get Unauthenticated => 'Vous n\'êtes pas authentifié. Veuillez vous connecter ou fournir des informations d\'identification valides pour continuer.';
}

// Path: firebaseErrors.auth
class TranslationsFirebaseErrorsAuthFr extends TranslationsFirebaseErrorsAuthEn {
	TranslationsFirebaseErrorsAuthFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get AdminRestrictedOperation => 'Vous n\'êtes pas autorisé à effectuer cette action.';
	@override String get ArgumentError => 'Quelque chose ne va pas avec les informations que vous avez fournies.';
	@override String get AppNotInstalled => 'Veuillez installer l\'application pour continuer.';
	@override String get CaptchaCheckFailed => 'Veuillez vérifier que vous n\'êtes pas un robot.';
	@override String get CodeExpired => 'Le code que vous avez saisi a expiré. Veuillez réessayer.';
	@override String get CredentialAlreadyInUse => 'Le compte est déjà utilisé par un autre utilisateur.';
	@override String get CustomTokenMismatch => 'Il y a un problème avec vos informations de connexion.';
	@override String get RequiresRecentLogin => 'Vous devez vous reconnecter pour effectuer cette action.';
	@override String get DynamicLinkNotActivated => 'Le lien auquel vous essayez d\'accéder n\'est plus actif.';
	@override String get EmailChangeNeedsVerification => 'Vous devez vérifier votre nouvelle adresse e-mail pour effectuer cette action.';
	@override String get EmailAlreadyInUse => 'Cet e-mail est déjà associé à un compte.';
	@override String get ExpiredActionCode => 'Le code que vous avez saisi a expiré. Veuillez réessayer.';
	@override String get CancelledPopupRequest => 'La demande de popup a été annulée.';
	@override String get InvalidVerificationCode => 'Le code de vérification est invalide. Veuillez réessayer.';
	@override String get InvalidEmail => 'L\'adresse e-mail que vous avez saisie est invalide. Veuillez réessayer.';
	@override String get UnauthorizedDomain => 'Vous n\'êtes pas autorisé à accéder à ce domaine.';
	@override String get WrongPassword => 'Le mot de passe que vous avez saisi est incorrect. Veuillez réessayer.';
	@override String get InvalidPhoneNumber => 'Le numéro de téléphone que vous avez saisi est invalide. Veuillez réessayer avec un numéro de téléphone valide.';
	@override String get InvalidRecipientEmail => 'L\'adresse e-mail du destinataire est invalide. Veuillez réessayer.';
	@override String get InvalidSender => 'L\'expéditeur est invalide. Veuillez réessayer.';
	@override String get MultiFactorAuthRequired => 'L\'authentification à plusieurs facteurs est requise pour effectuer ceci.';
	@override String get AccountExistsWithDifferentCredential => 'Un compte existe déjà avec cette adresse e-mail. Veuillez essayer de vous connecter avec une autre méthode.';
	@override String get NetworkRequestFailed => 'La demande réseau a échoué. Veuillez vérifier votre connexion Internet et réessayer.';
	@override String get OperationNotAllowed => 'Vous n\'êtes pas autorisé à effectuer cette opération.';
	@override String get PopupBlocked => 'Le popup a été bloqué. Veuillez autoriser les popups et réessayer.';
	@override String get ProviderAlreadyLinked => 'Le fournisseur est déjà lié à un autre compte. Veuillez réessayer.';
	@override String get SecondFactorAlreadyInUse => 'Le deuxième facteur est déjà utilisé. Veuillez réessayer.';
	@override String get MaximumSecondFactorCountExceeded => 'Le nombre maximal de seconds facteurs a été atteint. Veuillez réessayer.';
	@override String get Timeout => 'L\'opération a expiré. Veuillez réessayer.';
	@override String get TooManyRequests => 'Trop de demandes. Veuillez réessayer plus tard.';
	@override String get UnverifiedEmail => 'L\'adresse e-mail n\'a pas été vérifiée. Veuillez vérifier votre e-mail et suivre le lien de vérification.';
	@override String get UserNotFound => 'Le compte utilisateur n\'a pas été trouvé. Veuillez réessayer.';
	@override String get UserDisabled => 'Le compte utilisateur a été désactivé. Veuillez contacter le support pour obtenir de l\'aide.';
	@override String get UserSignedOut => 'Le compte utilisateur a été déconnecté. Veuillez vous reconnecter pour continuer.';
	@override String get WeakPassword => 'Le mot de passe est trop faible. Veuillez choisir un mot de passe plus fort.';
}

// Path: scaffold.greetings
class TranslationsScaffoldGreetingsFr extends TranslationsScaffoldGreetingsEn {
	TranslationsScaffoldGreetingsFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get morning => 'Bonjour';
	@override String get afternoon => 'Bon après-midi';
	@override String get evening => 'Bonsoir';
	@override String get night => 'Bonne nuit';
}

// Path: scaffold.fallbackPage
class TranslationsScaffoldFallbackPageFr extends TranslationsScaffoldFallbackPageEn {
	TranslationsScaffoldFallbackPageFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Page non trouvée';
	@override String get message => 'La page que vous cherchez n\'existe pas.';
}

// Path: scaffold.buttons
class TranslationsScaffoldButtonsFr extends TranslationsScaffoldButtonsEn {
	TranslationsScaffoldButtonsFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get goToSignIn => 'Aller à la connexion';
}

// Path: scaffold.dialogs
class TranslationsScaffoldDialogsFr extends TranslationsScaffoldDialogsEn {
	TranslationsScaffoldDialogsFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get confirm => 'Confirmer';
}

// Path: login.signInWith
class TranslationsLoginSignInWithFr extends TranslationsLoginSignInWithEn {
	TranslationsLoginSignInWithFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get password => 'Se connecter avec un mot de passe';
	@override String get magicLink => 'Se connecter avec un lien magique';
	@override String get google => 'Se connecter avec Google';
	@override String get apple => 'Se connecter avec Apple';
}

// Path: login.fields
class TranslationsLoginFieldsFr extends TranslationsLoginFieldsEn {
	TranslationsLoginFieldsFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final TranslationsLoginFieldsEmailFr email = TranslationsLoginFieldsEmailFr._(_root);
	@override late final TranslationsLoginFieldsPasswordFr password = TranslationsLoginFieldsPasswordFr._(_root);
}

// Path: login.forgotPassword
class TranslationsLoginForgotPasswordFr extends TranslationsLoginForgotPasswordEn {
	TranslationsLoginForgotPasswordFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final TranslationsLoginForgotPasswordButtonsFr buttons = TranslationsLoginForgotPasswordButtonsFr._(_root);
	@override late final TranslationsLoginForgotPasswordSentFr sent = TranslationsLoginForgotPasswordSentFr._(_root);
	@override late final TranslationsLoginForgotPasswordDialogFr dialog = TranslationsLoginForgotPasswordDialogFr._(_root);
}

// Path: login.magicLink
class TranslationsLoginMagicLinkFr extends TranslationsLoginMagicLinkEn {
	TranslationsLoginMagicLinkFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final TranslationsLoginMagicLinkSentFr sent = TranslationsLoginMagicLinkSentFr._(_root);
	@override late final TranslationsLoginMagicLinkButtonsFr buttons = TranslationsLoginMagicLinkButtonsFr._(_root);
}

// Path: login.buttons
class TranslationsLoginButtonsFr extends TranslationsLoginButtonsEn {
	TranslationsLoginButtonsFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get back => 'Retour à la page de connexion';
	@override String get signin => 'Se connecter';
}

// Path: forms.inputs.list
class TranslationsFormsInputsListFr extends TranslationsFormsInputsListEn {
	TranslationsFormsInputsListFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get add => 'Ajouter';
}

// Path: profile.fields.name
class TranslationsProfileFieldsNameFr extends TranslationsProfileFieldsNameEn {
	TranslationsProfileFieldsNameFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Nom';
	@override String get enter => 'Entrez votre nom';
	@override String get required => 'Nom requis';
}

// Path: profile.fields.email
class TranslationsProfileFieldsEmailFr extends TranslationsProfileFieldsEmailEn {
	TranslationsProfileFieldsEmailFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Adresse e-mail';
	@override String get enter => 'Entrez votre adresse e-mail';
	@override String get required => 'Adresse e-mail requise';
	@override String get invalid => 'Adresse e-mail invalide';
	@override late final TranslationsProfileFieldsEmailNoticesFr notices = TranslationsProfileFieldsEmailNoticesFr._(_root);
}

// Path: profile.fields.phone
class TranslationsProfileFieldsPhoneFr extends TranslationsProfileFieldsPhoneEn {
	TranslationsProfileFieldsPhoneFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Numéro de téléphone';
	@override String get enter => 'Entrez votre numéro de téléphone';
	@override String get required => 'Numéro de téléphone requis';
	@override String get invalid => 'Numéro de téléphone invalide';
}

// Path: profile.fields.language
class TranslationsProfileFieldsLanguageFr extends TranslationsProfileFieldsLanguageEn {
	TranslationsProfileFieldsLanguageFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Langue';
	@override String get select => 'Sélectionnez votre langue';
}

// Path: profile.verifyEmailCard.messages
class TranslationsProfileVerifyEmailCardMessagesFr extends TranslationsProfileVerifyEmailCardMessagesEn {
	TranslationsProfileVerifyEmailCardMessagesFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get sent => 'E-mail de vérification envoyé';
}

// Path: profile.verifyEmailCard.buttons
class TranslationsProfileVerifyEmailCardButtonsFr extends TranslationsProfileVerifyEmailCardButtonsEn {
	TranslationsProfileVerifyEmailCardButtonsFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get resend => 'Renvoyer l\'e-mail de vérification';
	@override String get back => 'Retour à la connexion';
	@override String get inbox => 'Aller à la boîte de réception';
}

// Path: login.fields.email
class TranslationsLoginFieldsEmailFr extends TranslationsLoginFieldsEmailEn {
	TranslationsLoginFieldsEmailFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Adresse e-mail';
	@override String get enter => 'Entrez votre adresse e-mail';
	@override String get required => 'Adresse e-mail obligatoire';
}

// Path: login.fields.password
class TranslationsLoginFieldsPasswordFr extends TranslationsLoginFieldsPasswordEn {
	TranslationsLoginFieldsPasswordFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Mot de passe';
	@override String get enter => 'Entrez votre mot de passe';
	@override String get required => 'Mot de passe obligatoire';
}

// Path: login.forgotPassword.buttons
class TranslationsLoginForgotPasswordButtonsFr extends TranslationsLoginForgotPasswordButtonsEn {
	TranslationsLoginForgotPasswordButtonsFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get forgot => 'Mot de passe oublié?';
	@override String get sendLink => 'Envoyer un lien de réinitialisation';
	@override String get inbox => 'Aller à la boîte de réception';
}

// Path: login.forgotPassword.sent
class TranslationsLoginForgotPasswordSentFr extends TranslationsLoginForgotPasswordSentEn {
	TranslationsLoginForgotPasswordSentFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Lien de réinitialisation envoyé';
	@override String get message => 'Un lien de réinitialisation a été envoyé à votre adresse e-mail. Veuillez vérifier votre boîte de réception et suivre le lien pour continuer. Si vous n\'avez pas reçu l\'e-mail, veuillez vérifier votre dossier de spam. Veuillez noter que cela peut prendre quelques minutes pour que l\'e-mail arrive, bien que cela ne prenne généralement que quelques secondes.';
}

// Path: login.forgotPassword.dialog
class TranslationsLoginForgotPasswordDialogFr extends TranslationsLoginForgotPasswordDialogEn {
	TranslationsLoginForgotPasswordDialogFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Réinitialiser le mot de passe';
	@override String get message => 'Veuillez entrer votre nouveau mot de passe et le confirmer en le saisissant à nouveau, puis cliquez sur le bouton ci-dessous.';
	@override late final TranslationsLoginForgotPasswordDialogFieldsFr fields = TranslationsLoginForgotPasswordDialogFieldsFr._(_root);
	@override late final TranslationsLoginForgotPasswordDialogButtonsFr buttons = TranslationsLoginForgotPasswordDialogButtonsFr._(_root);
	@override late final TranslationsLoginForgotPasswordDialogPopupsFr popups = TranslationsLoginForgotPasswordDialogPopupsFr._(_root);
}

// Path: login.magicLink.sent
class TranslationsLoginMagicLinkSentFr extends TranslationsLoginMagicLinkSentEn {
	TranslationsLoginMagicLinkSentFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Lien magique envoyé';
	@override String get message => 'Un lien magique a été envoyé à votre adresse e-mail. Veuillez vérifier votre boîte de réception et suivre le lien pour continuer. Si vous n\'avez pas reçu l\'e-mail, veuillez vérifier votre dossier de spam. Veuillez noter que cela peut prendre quelques minutes pour que l\'e-mail arrive, bien que cela ne prenne généralement que quelques secondes.';
}

// Path: login.magicLink.buttons
class TranslationsLoginMagicLinkButtonsFr extends TranslationsLoginMagicLinkButtonsEn {
	TranslationsLoginMagicLinkButtonsFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get send => 'Envoyer le lien magique';
	@override String get back => 'Retour à la page de connexion';
	@override String get inbox => 'Aller à la boîte de réception';
}

// Path: profile.fields.email.notices
class TranslationsProfileFieldsEmailNoticesFr extends TranslationsProfileFieldsEmailNoticesEn {
	TranslationsProfileFieldsEmailNoticesFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get change => 'Veuillez noter que toutes les modifications apportées à votre adresse e-mail ne seront pas appliquées tant que vous n\'aurez pas cliqué sur le bouton de vérification dans l\'e-mail que nous envoyons à votre ancienne adresse e-mail.';
	@override String get changeSent => 'Veuillez vérifier votre nouvelle adresse e-mail en cliquant sur le lien de vérification que nous avons envoyé à votre ancienne adresse e-mail. Il peut falloir quelques minutes pour que l\'e-mail arrive. Si vous ne le voyez pas, vérifiez votre dossier de courrier indésirable.';
}

// Path: login.forgotPassword.dialog.fields
class TranslationsLoginForgotPasswordDialogFieldsFr extends TranslationsLoginForgotPasswordDialogFieldsEn {
	TranslationsLoginForgotPasswordDialogFieldsFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final TranslationsLoginForgotPasswordDialogFieldsNewPasswordFr newPassword = TranslationsLoginForgotPasswordDialogFieldsNewPasswordFr._(_root);
	@override late final TranslationsLoginForgotPasswordDialogFieldsConfirmPasswordFr confirmPassword = TranslationsLoginForgotPasswordDialogFieldsConfirmPasswordFr._(_root);
}

// Path: login.forgotPassword.dialog.buttons
class TranslationsLoginForgotPasswordDialogButtonsFr extends TranslationsLoginForgotPasswordDialogButtonsEn {
	TranslationsLoginForgotPasswordDialogButtonsFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get update => 'Mettre à jour le mot de passe';
}

// Path: login.forgotPassword.dialog.popups
class TranslationsLoginForgotPasswordDialogPopupsFr extends TranslationsLoginForgotPasswordDialogPopupsEn {
	TranslationsLoginForgotPasswordDialogPopupsFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get passwordMismatch => 'Les mots de passe que vous avez saisis ne correspondent pas. Veuillez ressaisir votre mot de passe.';
	@override String get codeExpired => 'Le code de réinitialisation du mot de passe a expiré. Veuillez retourner à la page de connexion et renvoyer le lien de réinitialisation du mot de passe.';
	@override String get updateSuccess => 'Votre mot de passe a été mis à jour. Veuillez vous connecter avec votre nouveau mot de passe.';
}

// Path: login.forgotPassword.dialog.fields.newPassword
class TranslationsLoginForgotPasswordDialogFieldsNewPasswordFr extends TranslationsLoginForgotPasswordDialogFieldsNewPasswordEn {
	TranslationsLoginForgotPasswordDialogFieldsNewPasswordFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Nouveau mot de passe';
	@override String get enter => 'Entrez votre nouveau mot de passe';
	@override String get required => 'Nouveau mot de passe obligatoire';
	@override String get short => 'Le nouveau mot de passe est trop court';
}

// Path: login.forgotPassword.dialog.fields.confirmPassword
class TranslationsLoginForgotPasswordDialogFieldsConfirmPasswordFr extends TranslationsLoginForgotPasswordDialogFieldsConfirmPasswordEn {
	TranslationsLoginForgotPasswordDialogFieldsConfirmPasswordFr._(TranslationsFr root) : this._root = root, super._(root);

	@override final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Confirmer le mot de passe';
	@override String get enter => 'Confirmez votre nouveau mot de passe';
	@override String get required => 'Confirmation de mot de passe obligatoire';
	@override String get mismatch => 'Les mots de passe ne correspondent pas';
}

// Path: <root>
class TranslationsNl extends TranslationsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsNl.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.nl,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super.build(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	/// Metadata for the translations of <nl>.
	@override final TranslationMetadata<AppLocale, TranslationsEn> $meta;

	@override late final TranslationsNl _root = this; // ignore: unused_field

	// Translations
	@override late final TranslationsFormsNl forms = TranslationsFormsNl._(_root);
	@override late final TranslationsProfileNl profile = TranslationsProfileNl._(_root);
	@override late final TranslationsFirebaseErrorsNl firebaseErrors = TranslationsFirebaseErrorsNl._(_root);
	@override late final TranslationsScaffoldNl scaffold = TranslationsScaffoldNl._(_root);
	@override late final TranslationsLoginNl login = TranslationsLoginNl._(_root);
}

// Path: forms
class TranslationsFormsNl extends TranslationsFormsEn {
	TranslationsFormsNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final TranslationsFormsButtonsNl buttons = TranslationsFormsButtonsNl._(_root);
	@override String get selectAnOption => 'Selecteer een optie';
	@override late final TranslationsFormsInputsNl inputs = TranslationsFormsInputsNl._(_root);
}

// Path: profile
class TranslationsProfileNl extends TranslationsProfileEn {
	TranslationsProfileNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get signOut => 'Afmelden';
	@override late final TranslationsProfileMessagesNl messages = TranslationsProfileMessagesNl._(_root);
	@override late final TranslationsProfilePageNl page = TranslationsProfilePageNl._(_root);
	@override late final TranslationsProfileDeleteAccountNl deleteAccount = TranslationsProfileDeleteAccountNl._(_root);
	@override late final TranslationsProfileFieldsNl fields = TranslationsProfileFieldsNl._(_root);
	@override late final TranslationsProfileVerifyEmailCardNl verifyEmailCard = TranslationsProfileVerifyEmailCardNl._(_root);
}

// Path: firebaseErrors
class TranslationsFirebaseErrorsNl extends TranslationsFirebaseErrorsEn {
	TranslationsFirebaseErrorsNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get unknown => 'Er is iets misgegaan. Probeer het later opnieuw.';
	@override late final TranslationsFirebaseErrorsHttpsNl https = TranslationsFirebaseErrorsHttpsNl._(_root);
	@override late final TranslationsFirebaseErrorsAuthNl auth = TranslationsFirebaseErrorsAuthNl._(_root);
}

// Path: scaffold
class TranslationsScaffoldNl extends TranslationsScaffoldEn {
	TranslationsScaffoldNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final TranslationsScaffoldGreetingsNl greetings = TranslationsScaffoldGreetingsNl._(_root);
	@override String get search => 'Zoek...';
	@override String get guest => 'Niet ingelogd';
	@override late final TranslationsScaffoldFallbackPageNl fallbackPage = TranslationsScaffoldFallbackPageNl._(_root);
	@override late final TranslationsScaffoldButtonsNl buttons = TranslationsScaffoldButtonsNl._(_root);
	@override late final TranslationsScaffoldDialogsNl dialogs = TranslationsScaffoldDialogsNl._(_root);
}

// Path: login
class TranslationsLoginNl extends TranslationsLoginEn {
	TranslationsLoginNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final TranslationsLoginSignInWithNl signInWith = TranslationsLoginSignInWithNl._(_root);
	@override late final TranslationsLoginFieldsNl fields = TranslationsLoginFieldsNl._(_root);
	@override late final TranslationsLoginForgotPasswordNl forgotPassword = TranslationsLoginForgotPasswordNl._(_root);
	@override late final TranslationsLoginMagicLinkNl magicLink = TranslationsLoginMagicLinkNl._(_root);
	@override late final TranslationsLoginButtonsNl buttons = TranslationsLoginButtonsNl._(_root);
}

// Path: forms.buttons
class TranslationsFormsButtonsNl extends TranslationsFormsButtonsEn {
	TranslationsFormsButtonsNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get save => 'Wijzigingen opslaan';
	@override String get undo => 'Wijzigingen ongedaan maken';
	@override String get create => 'Creëren';
}

// Path: forms.inputs
class TranslationsFormsInputsNl extends TranslationsFormsInputsEn {
	TranslationsFormsInputsNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final TranslationsFormsInputsListNl list = TranslationsFormsInputsListNl._(_root);
}

// Path: profile.messages
class TranslationsProfileMessagesNl extends TranslationsProfileMessagesEn {
	TranslationsProfileMessagesNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get passwordUpdated => 'Wachtwoord succesvol bijgewerkt';
	@override String get passwordRemoved => 'Wachtwoord succesvol verwijderd';
}

// Path: profile.page
class TranslationsProfilePageNl extends TranslationsProfilePageEn {
	TranslationsProfilePageNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Mijn profiel';
	@override String get description => 'Beheer uw account, log in en persoonlijke gegevens';
}

// Path: profile.deleteAccount
class TranslationsProfileDeleteAccountNl extends TranslationsProfileDeleteAccountEn {
	TranslationsProfileDeleteAccountNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get button => 'Account verwijderen';
	@override String get warning => 'Weet u zeker dat u uw account wilt verwijderen? Deze actie kan niet ongedaan worden gemaakt.';
}

// Path: profile.fields
class TranslationsProfileFieldsNl extends TranslationsProfileFieldsEn {
	TranslationsProfileFieldsNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final TranslationsProfileFieldsNameNl name = TranslationsProfileFieldsNameNl._(_root);
	@override late final TranslationsProfileFieldsEmailNl email = TranslationsProfileFieldsEmailNl._(_root);
	@override late final TranslationsProfileFieldsPhoneNl phone = TranslationsProfileFieldsPhoneNl._(_root);
	@override late final TranslationsProfileFieldsLanguageNl language = TranslationsProfileFieldsLanguageNl._(_root);
}

// Path: profile.verifyEmailCard
class TranslationsProfileVerifyEmailCardNl extends TranslationsProfileVerifyEmailCardEn {
	TranslationsProfileVerifyEmailCardNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'E-mailadres verificatie';
	@override String get message => 'Om uw account te gebruiken, moet u uw e-mailadres verifiëren. We hebben u een e-mail gestuurd met een verificatielink. Klik op de link om uw e-mailadres te verifiëren. Het kan enkele minuten duren voordat de e-mail aankomt. Als u de e-mail niet ziet, controleer dan uw spammap.';
	@override late final TranslationsProfileVerifyEmailCardMessagesNl messages = TranslationsProfileVerifyEmailCardMessagesNl._(_root);
	@override late final TranslationsProfileVerifyEmailCardButtonsNl buttons = TranslationsProfileVerifyEmailCardButtonsNl._(_root);
}

// Path: firebaseErrors.https
class TranslationsFirebaseErrorsHttpsNl extends TranslationsFirebaseErrorsHttpsEn {
	TranslationsFirebaseErrorsHttpsNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get DeadlineExceeded => 'De bewerking is verlopen. Probeer het later opnieuw.';
	@override String get NotFound => 'Kon niet vinden waar u naar op zoek was. Probeer het opnieuw.';
	@override String get AlreadyExists => 'Dit bestaat al. Probeer het opnieuw met andere details.';
	@override String get PermissionDenied => 'U heeft geen toestemming om deze actie uit te voeren.';
	@override String get Unimplemented => 'Deze functie wordt momenteel niet ondersteund. Kom later terug.';
	@override String get Unavailable => 'De service is momenteel niet beschikbaar. Probeer het later opnieuw.';
	@override String get Unauthenticated => 'U bent niet geauthenticeerd. Log in of geef geldige inloggegevens om door te gaan.';
}

// Path: firebaseErrors.auth
class TranslationsFirebaseErrorsAuthNl extends TranslationsFirebaseErrorsAuthEn {
	TranslationsFirebaseErrorsAuthNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get AdminRestrictedOperation => 'U bent niet gemachtigd om deze actie uit te voeren.';
	@override String get ArgumentError => 'Er is iets mis met de informatie die u heeft verstrekt.';
	@override String get AppNotInstalled => 'Installeer de app om verder te gaan.';
	@override String get CaptchaCheckFailed => 'Verifieer dat u geen robot bent.';
	@override String get CodeExpired => 'De code die u heeft ingevoerd is verlopen. Probeer het opnieuw.';
	@override String get CredentialAlreadyInUse => 'Het account is al in gebruik door een andere gebruiker.';
	@override String get CustomTokenMismatch => 'Er is een probleem met uw inloggegevens.';
	@override String get RequiresRecentLogin => 'U moet opnieuw inloggen om deze actie te voltooien.';
	@override String get DynamicLinkNotActivated => 'De link waartoe u probeert toegang te krijgen, is niet langer actief.';
	@override String get EmailChangeNeedsVerification => 'U moet uw nieuwe e-mailadres verifiëren om deze actie te voltooien.';
	@override String get EmailAlreadyInUse => 'Dit e-mailadres is al gekoppeld aan een account.';
	@override String get ExpiredActionCode => 'De code die u heeft ingevoerd is verlopen. Probeer het opnieuw.';
	@override String get CancelledPopupRequest => 'Het pop-upverzoek is geannuleerd.';
	@override String get InvalidVerificationCode => 'De verificatiecode is ongeldig. Probeer het opnieuw.';
	@override String get InvalidEmail => 'Het e-mailadres dat u heeft ingevoerd is ongeldig. Probeer het opnieuw.';
	@override String get UnauthorizedDomain => 'U heeft geen toestemming om toegang te krijgen tot dit domein.';
	@override String get WrongPassword => 'Het wachtwoord dat u heeft ingevoerd is onjuist. Probeer het opnieuw.';
	@override String get InvalidPhoneNumber => 'Het telefoonnummer dat u heeft ingevoerd is ongeldig. Probeer het opnieuw met een geldig telefoonnummer.';
	@override String get InvalidRecipientEmail => 'Het e-mailadres van de ontvanger is ongeldig. Probeer het opnieuw.';
	@override String get InvalidSender => 'De afzender is ongeldig. Probeer het opnieuw.';
	@override String get MultiFactorAuthRequired => 'Multi-factor authenticatie is vereist om dit te voltooien.';
	@override String get AccountExistsWithDifferentCredential => 'Er bestaat al een account met dit e-mailadres. Probeer in te loggen met een andere methode.';
	@override String get NetworkRequestFailed => 'Het netwerkverzoek is mislukt. Controleer uw internetverbinding en probeer het opnieuw.';
	@override String get OperationNotAllowed => 'U mag deze bewerking niet uitvoeren.';
	@override String get PopupBlocked => 'De pop-up is geblokkeerd. Sta pop-ups toe en probeer het opnieuw.';
	@override String get ProviderAlreadyLinked => 'De provider is al gekoppeld aan een ander account. Probeer het opnieuw.';
	@override String get SecondFactorAlreadyInUse => 'De tweede factor is al in gebruik. Probeer het opnieuw.';
	@override String get MaximumSecondFactorCountExceeded => 'Het maximale aantal tweede factoren is bereikt. Probeer het opnieuw.';
	@override String get Timeout => 'De bewerking is verlopen. Probeer het opnieuw.';
	@override String get TooManyRequests => 'Te veel verzoeken. Probeer het later opnieuw.';
	@override String get UnverifiedEmail => 'Het e-mailadres is niet geverifieerd. Controleer uw e-mail en volg de verificatielink.';
	@override String get UserNotFound => 'Het gebruikersaccount is niet gevonden. Probeer het opnieuw.';
	@override String get UserDisabled => 'Het gebruikersaccount is uitgeschakeld. Neem contact op met de ondersteuning voor hulp.';
	@override String get UserSignedOut => 'Het gebruikersaccount is afgemeld. Log opnieuw in om door te gaan.';
	@override String get WeakPassword => 'Het wachtwoord is te zwak. Kies een sterker wachtwoord.';
}

// Path: scaffold.greetings
class TranslationsScaffoldGreetingsNl extends TranslationsScaffoldGreetingsEn {
	TranslationsScaffoldGreetingsNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get morning => 'Goedemorgen';
	@override String get afternoon => 'Goedemiddag';
	@override String get evening => 'Goedenavond';
	@override String get night => 'Goedenacht';
}

// Path: scaffold.fallbackPage
class TranslationsScaffoldFallbackPageNl extends TranslationsScaffoldFallbackPageEn {
	TranslationsScaffoldFallbackPageNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pagina niet gevonden';
	@override String get message => 'De pagina die u zoekt bestaat niet.';
}

// Path: scaffold.buttons
class TranslationsScaffoldButtonsNl extends TranslationsScaffoldButtonsEn {
	TranslationsScaffoldButtonsNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get goToSignIn => 'Inloggen';
}

// Path: scaffold.dialogs
class TranslationsScaffoldDialogsNl extends TranslationsScaffoldDialogsEn {
	TranslationsScaffoldDialogsNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get confirm => 'Bevestigen';
}

// Path: login.signInWith
class TranslationsLoginSignInWithNl extends TranslationsLoginSignInWithEn {
	TranslationsLoginSignInWithNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get password => 'Inloggen met wachtwoord';
	@override String get magicLink => 'Inloggen met magische link';
	@override String get google => 'Inloggen met Google';
	@override String get apple => 'Inloggen met Apple';
}

// Path: login.fields
class TranslationsLoginFieldsNl extends TranslationsLoginFieldsEn {
	TranslationsLoginFieldsNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final TranslationsLoginFieldsEmailNl email = TranslationsLoginFieldsEmailNl._(_root);
	@override late final TranslationsLoginFieldsPasswordNl password = TranslationsLoginFieldsPasswordNl._(_root);
}

// Path: login.forgotPassword
class TranslationsLoginForgotPasswordNl extends TranslationsLoginForgotPasswordEn {
	TranslationsLoginForgotPasswordNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final TranslationsLoginForgotPasswordButtonsNl buttons = TranslationsLoginForgotPasswordButtonsNl._(_root);
	@override late final TranslationsLoginForgotPasswordSentNl sent = TranslationsLoginForgotPasswordSentNl._(_root);
	@override late final TranslationsLoginForgotPasswordDialogNl dialog = TranslationsLoginForgotPasswordDialogNl._(_root);
}

// Path: login.magicLink
class TranslationsLoginMagicLinkNl extends TranslationsLoginMagicLinkEn {
	TranslationsLoginMagicLinkNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final TranslationsLoginMagicLinkSentNl sent = TranslationsLoginMagicLinkSentNl._(_root);
	@override late final TranslationsLoginMagicLinkButtonsNl buttons = TranslationsLoginMagicLinkButtonsNl._(_root);
}

// Path: login.buttons
class TranslationsLoginButtonsNl extends TranslationsLoginButtonsEn {
	TranslationsLoginButtonsNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get back => 'Terug naar inloggen';
	@override String get signin => 'Inloggen';
}

// Path: forms.inputs.list
class TranslationsFormsInputsListNl extends TranslationsFormsInputsListEn {
	TranslationsFormsInputsListNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get add => 'Toevoegen';
}

// Path: profile.fields.name
class TranslationsProfileFieldsNameNl extends TranslationsProfileFieldsNameEn {
	TranslationsProfileFieldsNameNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get label => 'Naam';
	@override String get enter => 'Voer uw naam in';
	@override String get required => 'Naam is verplicht';
}

// Path: profile.fields.email
class TranslationsProfileFieldsEmailNl extends TranslationsProfileFieldsEmailEn {
	TranslationsProfileFieldsEmailNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get label => 'E-mailadres';
	@override String get enter => 'Voer uw e-mailadres in';
	@override String get required => 'E-mailadres is verplicht';
	@override String get invalid => 'Ongeldig e-mailadres';
	@override late final TranslationsProfileFieldsEmailNoticesNl notices = TranslationsProfileFieldsEmailNoticesNl._(_root);
}

// Path: profile.fields.phone
class TranslationsProfileFieldsPhoneNl extends TranslationsProfileFieldsPhoneEn {
	TranslationsProfileFieldsPhoneNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get label => 'Telefoonnummer';
	@override String get enter => 'Voer uw telefoonnummer in';
	@override String get required => 'Telefoonnummer is verplicht';
	@override String get invalid => 'Ongeldig telefoonnummer';
}

// Path: profile.fields.language
class TranslationsProfileFieldsLanguageNl extends TranslationsProfileFieldsLanguageEn {
	TranslationsProfileFieldsLanguageNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get label => 'Taal';
	@override String get select => 'Selecteer uw taal';
}

// Path: profile.verifyEmailCard.messages
class TranslationsProfileVerifyEmailCardMessagesNl extends TranslationsProfileVerifyEmailCardMessagesEn {
	TranslationsProfileVerifyEmailCardMessagesNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get sent => 'Verificatie-e-mail verzonden';
}

// Path: profile.verifyEmailCard.buttons
class TranslationsProfileVerifyEmailCardButtonsNl extends TranslationsProfileVerifyEmailCardButtonsEn {
	TranslationsProfileVerifyEmailCardButtonsNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get resend => 'Verificatie-e-mail opnieuw verzenden';
	@override String get back => 'Terug naar login';
	@override String get inbox => 'Ga naar inbox';
}

// Path: login.fields.email
class TranslationsLoginFieldsEmailNl extends TranslationsLoginFieldsEmailEn {
	TranslationsLoginFieldsEmailNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get label => 'E-mailadres';
	@override String get enter => 'Voer uw e-mailadres in';
	@override String get required => 'E-mailadres is verplicht';
}

// Path: login.fields.password
class TranslationsLoginFieldsPasswordNl extends TranslationsLoginFieldsPasswordEn {
	TranslationsLoginFieldsPasswordNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get label => 'Wachtwoord';
	@override String get enter => 'Voer uw wachtwoord in';
	@override String get required => 'Wachtwoord is verplicht';
}

// Path: login.forgotPassword.buttons
class TranslationsLoginForgotPasswordButtonsNl extends TranslationsLoginForgotPasswordButtonsEn {
	TranslationsLoginForgotPasswordButtonsNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get forgot => 'Wachtwoord vergeten?';
	@override String get sendLink => 'Stuur wachtwoordherstel-link';
	@override String get inbox => 'Ga naar inbox';
}

// Path: login.forgotPassword.sent
class TranslationsLoginForgotPasswordSentNl extends TranslationsLoginForgotPasswordSentEn {
	TranslationsLoginForgotPasswordSentNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wachtwoordherstel-link verzonden';
	@override String get message => 'Er is een link om uw wachtwoord opnieuw in te stellen naar uw e-mailadres gestuurd. Controleer uw inbox en volg de link om verder te gaan. Als u de e-mail niet heeft ontvangen, controleer dan uw spammap. Houd er rekening mee dat het enkele minuten kan duren voordat de e-mail arriveert, hoewel het meestal slechts enkele seconden is.';
}

// Path: login.forgotPassword.dialog
class TranslationsLoginForgotPasswordDialogNl extends TranslationsLoginForgotPasswordDialogEn {
	TranslationsLoginForgotPasswordDialogNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wachtwoord opnieuw instellen';
	@override String get message => 'Voer uw nieuwe wachtwoord in en herhaal het om te bevestigen. Klik vervolgens op de knop hieronder.';
	@override late final TranslationsLoginForgotPasswordDialogFieldsNl fields = TranslationsLoginForgotPasswordDialogFieldsNl._(_root);
	@override late final TranslationsLoginForgotPasswordDialogButtonsNl buttons = TranslationsLoginForgotPasswordDialogButtonsNl._(_root);
	@override late final TranslationsLoginForgotPasswordDialogPopupsNl popups = TranslationsLoginForgotPasswordDialogPopupsNl._(_root);
}

// Path: login.magicLink.sent
class TranslationsLoginMagicLinkSentNl extends TranslationsLoginMagicLinkSentEn {
	TranslationsLoginMagicLinkSentNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Magische link verzonden';
	@override String get message => 'Er is een magische link naar uw e-mailadres gestuurd. Controleer uw inbox en volg de link om verder te gaan. Als u de e-mail niet heeft ontvangen, controleer dan uw spammap. Houd er rekening mee dat het enkele minuten kan duren voordat de e-mail arriveert, hoewel het meestal slechts enkele seconden is.';
}

// Path: login.magicLink.buttons
class TranslationsLoginMagicLinkButtonsNl extends TranslationsLoginMagicLinkButtonsEn {
	TranslationsLoginMagicLinkButtonsNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get send => 'Stuur magische link';
	@override String get back => 'Terug naar inloggen';
	@override String get inbox => 'Ga naar inbox';
}

// Path: profile.fields.email.notices
class TranslationsProfileFieldsEmailNoticesNl extends TranslationsProfileFieldsEmailNoticesEn {
	TranslationsProfileFieldsEmailNoticesNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get change => 'Houd er rekening mee dat eventuele wijzigingen in uw e-mailadres pas worden toegepast nadat u op de verificatieknop in de e-mail hebt geklikt die we naar uw oude e-mailadres hebben gestuurd.';
	@override String get changeSent => 'Verifieer uw nieuwe e-mailadres door op de verificatielink te klikken die we naar uw oude e-mail hebben gestuurd. Het kan enkele minuten duren voordat de e-mail aankomt. Als u deze niet ziet, controleer dan uw spammap.';
}

// Path: login.forgotPassword.dialog.fields
class TranslationsLoginForgotPasswordDialogFieldsNl extends TranslationsLoginForgotPasswordDialogFieldsEn {
	TranslationsLoginForgotPasswordDialogFieldsNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final TranslationsLoginForgotPasswordDialogFieldsNewPasswordNl newPassword = TranslationsLoginForgotPasswordDialogFieldsNewPasswordNl._(_root);
	@override late final TranslationsLoginForgotPasswordDialogFieldsConfirmPasswordNl confirmPassword = TranslationsLoginForgotPasswordDialogFieldsConfirmPasswordNl._(_root);
}

// Path: login.forgotPassword.dialog.buttons
class TranslationsLoginForgotPasswordDialogButtonsNl extends TranslationsLoginForgotPasswordDialogButtonsEn {
	TranslationsLoginForgotPasswordDialogButtonsNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get update => 'Wachtwoord bijwerken';
}

// Path: login.forgotPassword.dialog.popups
class TranslationsLoginForgotPasswordDialogPopupsNl extends TranslationsLoginForgotPasswordDialogPopupsEn {
	TranslationsLoginForgotPasswordDialogPopupsNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get passwordMismatch => 'De ingevoerde wachtwoorden komen niet overeen. Voer uw wachtwoord opnieuw in.';
	@override String get codeExpired => 'De wachtwoordherstelcode is verlopen. Ga terug naar inloggen en stuur de wachtwoordherstel-link opnieuw.';
	@override String get updateSuccess => 'Uw wachtwoord is bijgewerkt. Log in met uw nieuwe wachtwoord.';
}

// Path: login.forgotPassword.dialog.fields.newPassword
class TranslationsLoginForgotPasswordDialogFieldsNewPasswordNl extends TranslationsLoginForgotPasswordDialogFieldsNewPasswordEn {
	TranslationsLoginForgotPasswordDialogFieldsNewPasswordNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get label => 'Nieuw wachtwoord';
	@override String get enter => 'Voer uw nieuwe wachtwoord in';
	@override String get required => 'Nieuw wachtwoord is vereist';
	@override String get short => 'Nieuw wachtwoord is te kort';
}

// Path: login.forgotPassword.dialog.fields.confirmPassword
class TranslationsLoginForgotPasswordDialogFieldsConfirmPasswordNl extends TranslationsLoginForgotPasswordDialogFieldsConfirmPasswordEn {
	TranslationsLoginForgotPasswordDialogFieldsConfirmPasswordNl._(TranslationsNl root) : this._root = root, super._(root);

	@override final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get label => 'Bevestig wachtwoord';
	@override String get enter => 'Bevestig uw nieuwe wachtwoord';
	@override String get required => 'Bevestiging van wachtwoord is vereist';
	@override String get mismatch => 'Wachtwoorden komen niet overeen';
}
