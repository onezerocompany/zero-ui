/// Generated file. Do not edit.
///
/// Locales: 2
/// Strings: 131 (65 per locale)
///
/// Built on 2023-03-14 at 01:42 UTC

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
	late final TranslationsFormEn form = TranslationsFormEn._(_root);
	late final TranslationsProfileEn profile = TranslationsProfileEn._(_root);
	late final TranslationsFirebaseErrorsEn firebaseErrors = TranslationsFirebaseErrorsEn._(_root);
	late final TranslationsScaffoldEn scaffold = TranslationsScaffoldEn._(_root);
	late final TranslationsLoginEn login = TranslationsLoginEn._(_root);
}

// Path: form
class TranslationsFormEn {
	TranslationsFormEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	late final TranslationsFormButtonsEn buttons = TranslationsFormButtonsEn._(_root);
	late final TranslationsFormInputsEn inputs = TranslationsFormInputsEn._(_root);
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

// Path: form.buttons
class TranslationsFormButtonsEn {
	TranslationsFormButtonsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	String get save => 'Save Changes';
	String get undo => 'Undo Changes';
	String get create => 'Create';
}

// Path: form.inputs
class TranslationsFormInputsEn {
	TranslationsFormInputsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	late final TranslationsFormInputsListEn list = TranslationsFormInputsListEn._(_root);
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
	String get Unimplemented => 'This feature is not currently supported. Please check back ter.",';
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

// Path: form.inputs.list
class TranslationsFormInputsListEn {
	TranslationsFormInputsListEn._(this._root);

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
	@override late final TranslationsScaffoldNl scaffold = TranslationsScaffoldNl._(_root);
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
