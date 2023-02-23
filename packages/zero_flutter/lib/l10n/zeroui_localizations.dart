import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'zeroui_localizations_en.dart';
import 'zeroui_localizations_nl.dart';

/// Callers can lookup localized strings with an instance of ZeroUIAppLocalizations
/// returned by `ZeroUIAppLocalizations.of(context)`.
///
/// Applications need to include `ZeroUIAppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/zeroui_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ZeroUIAppLocalizations.localizationsDelegates,
///   supportedLocales: ZeroUIAppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the ZeroUIAppLocalizations.supportedLocales
/// property.
abstract class ZeroUIAppLocalizations {
  ZeroUIAppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ZeroUIAppLocalizations? of(BuildContext context) {
    return Localizations.of<ZeroUIAppLocalizations>(context, ZeroUIAppLocalizations);
  }

  static const LocalizationsDelegate<ZeroUIAppLocalizations> delegate = _ZeroUIAppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('nl')
  ];

  /// No description provided for @generalErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again later.'**
  String get generalErrorMessage;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @omniSearchField.
  ///
  /// In en, this message translates to:
  /// **'Search here...'**
  String get omniSearchField;

  /// No description provided for @passwordToggle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with password'**
  String get passwordToggle;

  /// No description provided for @magicLinkToggle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with magic link'**
  String get magicLinkToggle;

  /// No description provided for @googleSignInButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get googleSignInButtonLabel;

  /// No description provided for @appleSignInButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple'**
  String get appleSignInButtonLabel;

  /// No description provided for @emailAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddressLabel;

  /// No description provided for @emailAddressPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get emailAddressPlaceholder;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get nameLabel;

  /// No description provided for @namePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get namePlaceholder;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get nameRequired;

  /// No description provided for @phoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumberLabel;

  /// No description provided for @phoneNumberPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get phoneNumberPlaceholder;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordPlaceholder;

  /// No description provided for @magicLinkSignInButton.
  ///
  /// In en, this message translates to:
  /// **'Send magic link'**
  String get magicLinkSignInButton;

  /// No description provided for @passwordSignInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get passwordSignInButton;

  /// No description provided for @forgotPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPasswordButton;

  /// No description provided for @returnToLoginButton.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get returnToLoginButton;

  /// No description provided for @forgotPasswordSendButton.
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
  String get forgotPasswordSendButton;

  /// No description provided for @signOutButton.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOutButton;

  /// No description provided for @fallbackPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get fallbackPageTitle;

  /// No description provided for @fallbackPageMessage.
  ///
  /// In en, this message translates to:
  /// **'The page you are looking for does not exist.'**
  String get fallbackPageMessage;

  /// No description provided for @fallbackPageButton.
  ///
  /// In en, this message translates to:
  /// **'Go to homepage'**
  String get fallbackPageButton;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get goodEvening;

  /// No description provided for @goodNight.
  ///
  /// In en, this message translates to:
  /// **'Good night'**
  String get goodNight;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @languageSelectLabel.
  ///
  /// In en, this message translates to:
  /// **'Select your language'**
  String get languageSelectLabel;

  /// No description provided for @saveChangesButton.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChangesButton;

  /// No description provided for @deleteAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccountButton;

  /// No description provided for @validateEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Email verification'**
  String get validateEmailTitle;

  /// No description provided for @validateEmailBody.
  ///
  /// In en, this message translates to:
  /// **'We sent a verification email to your email address. Please check your inbox and click the link to verify.'**
  String get validateEmailBody;

  /// No description provided for @validateEmailButton.
  ///
  /// In en, this message translates to:
  /// **'Resend verification email'**
  String get validateEmailButton;

  /// No description provided for @validateEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Verification email sent'**
  String get validateEmailSent;

  /// No description provided for @undoChangesButton.
  ///
  /// In en, this message translates to:
  /// **'Undo changes'**
  String get undoChangesButton;

  /// No description provided for @phoneNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get phoneNumberRequired;

  /// No description provided for @phoneNumberInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get phoneNumberInvalid;

  /// No description provided for @emailAddressRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address'**
  String get emailAddressRequired;

  /// No description provided for @emailAddressInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get emailAddressInvalid;

  /// No description provided for @deleteAccountDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccountDialogTitle;

  /// No description provided for @deleteAccountDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone.'**
  String get deleteAccountDialogMessage;

  /// No description provided for @deleteAccountDialogButton.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccountDialogButton;

  /// No description provided for @goToSignInPage.
  ///
  /// In en, this message translates to:
  /// **'Go to Sign In'**
  String get goToSignInPage;

  /// No description provided for @returnHomeButton.
  ///
  /// In en, this message translates to:
  /// **'Return to Home'**
  String get returnHomeButton;

  /// No description provided for @emailAddressNotFound.
  ///
  /// In en, this message translates to:
  /// **'Email address not found'**
  String get emailAddressNotFound;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password'**
  String get wrongPassword;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @userDisabled.
  ///
  /// In en, this message translates to:
  /// **'User disabled'**
  String get userDisabled;

  /// No description provided for @resendVerificationEmailError.
  ///
  /// In en, this message translates to:
  /// **'Failed to send verification email. Please try again later.'**
  String get resendVerificationEmailError;
}

class _ZeroUIAppLocalizationsDelegate extends LocalizationsDelegate<ZeroUIAppLocalizations> {
  const _ZeroUIAppLocalizationsDelegate();

  @override
  Future<ZeroUIAppLocalizations> load(Locale locale) {
    return SynchronousFuture<ZeroUIAppLocalizations>(lookupZeroUIAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'nl'].contains(locale.languageCode);

  @override
  bool shouldReload(_ZeroUIAppLocalizationsDelegate old) => false;
}

ZeroUIAppLocalizations lookupZeroUIAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return ZeroUIAppLocalizationsEn();
    case 'nl': return ZeroUIAppLocalizationsNl();
  }

  throw FlutterError(
    'ZeroUIAppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
