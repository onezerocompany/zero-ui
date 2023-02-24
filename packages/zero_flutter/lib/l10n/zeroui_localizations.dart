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

  /// No description provided for @authErrorAdminRestrictedOperation.
  ///
  /// In en, this message translates to:
  /// **'You are not authorized to perform this action.'**
  String get authErrorAdminRestrictedOperation;

  /// No description provided for @authErrorArgumentError.
  ///
  /// In en, this message translates to:
  /// **'Something is wrong with the information you provided.'**
  String get authErrorArgumentError;

  /// No description provided for @authErrorAppNotAuthorized.
  ///
  /// In en, this message translates to:
  /// **'The app is not authorized to access your account.'**
  String get authErrorAppNotAuthorized;

  /// No description provided for @authErrorAppNotInstalled.
  ///
  /// In en, this message translates to:
  /// **'Please install the app to continue.'**
  String get authErrorAppNotInstalled;

  /// No description provided for @authErrorCaptchaCheckFailed.
  ///
  /// In en, this message translates to:
  /// **'Please verify that you are not a robot.'**
  String get authErrorCaptchaCheckFailed;

  /// No description provided for @authErrorCodeExpired.
  ///
  /// In en, this message translates to:
  /// **'The code you entered has expired. Please try again.'**
  String get authErrorCodeExpired;

  /// No description provided for @authErrorCorsUnsupported.
  ///
  /// In en, this message translates to:
  /// **'This feature is not supported in your current browser.'**
  String get authErrorCorsUnsupported;

  /// No description provided for @authErrorCredentialAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'The account is already in use by another user.'**
  String get authErrorCredentialAlreadyInUse;

  /// No description provided for @authErrorCustomTokenMismatch.
  ///
  /// In en, this message translates to:
  /// **'There is a problem with your login credentials.'**
  String get authErrorCustomTokenMismatch;

  /// No description provided for @authErrorRequiresRecentLogin.
  ///
  /// In en, this message translates to:
  /// **'You need to login again to complete this action.'**
  String get authErrorRequiresRecentLogin;

  /// No description provided for @authErrorDependentSdkInitializedBeforeAuth.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed. Please try again.'**
  String get authErrorDependentSdkInitializedBeforeAuth;

  /// No description provided for @authErrorDynamicLinkNotActivated.
  ///
  /// In en, this message translates to:
  /// **'The link you are trying to access is no longer active.'**
  String get authErrorDynamicLinkNotActivated;

  /// No description provided for @authErrorEmailChangeNeedsVerification.
  ///
  /// In en, this message translates to:
  /// **'You need to verify your new email address to complete this action.'**
  String get authErrorEmailChangeNeedsVerification;

  /// No description provided for @authErrorEmailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already associated with an account.'**
  String get authErrorEmailAlreadyInUse;

  /// No description provided for @authErrorEmulatorConfigFailed.
  ///
  /// In en, this message translates to:
  /// **'There is a problem with the emulator configuration.'**
  String get authErrorEmulatorConfigFailed;

  /// No description provided for @authErrorExpiredActionCode.
  ///
  /// In en, this message translates to:
  /// **'The code you entered has expired. Please try again.'**
  String get authErrorExpiredActionCode;

  /// No description provided for @authErrorCancelledPopupRequest.
  ///
  /// In en, this message translates to:
  /// **'The popup request was cancelled.'**
  String get authErrorCancelledPopupRequest;

  /// No description provided for @authErrorInternalError.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed due to an internal error. Please try again.'**
  String get authErrorInternalError;

  /// No description provided for @authErrorInvalidApiKey.
  ///
  /// In en, this message translates to:
  /// **'The API key you provided is invalid.'**
  String get authErrorInvalidApiKey;

  /// No description provided for @authErrorInvalidAppCredential.
  ///
  /// In en, this message translates to:
  /// **'The app credentials are invalid.'**
  String get authErrorInvalidAppCredential;

  /// No description provided for @authErrorInvalidAppId.
  ///
  /// In en, this message translates to:
  /// **'The app ID is invalid.'**
  String get authErrorInvalidAppId;

  /// No description provided for @authErrorInvalidUserToken.
  ///
  /// In en, this message translates to:
  /// **'The user token is invalid. Please try logging in again.'**
  String get authErrorInvalidUserToken;

  /// No description provided for @authErrorInvalidAuthEvent.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed due to an invalid event.'**
  String get authErrorInvalidAuthEvent;

  /// No description provided for @authErrorInvalidCertHash.
  ///
  /// In en, this message translates to:
  /// **'The certificate hash is invalid. Please try again.'**
  String get authErrorInvalidCertHash;

  /// No description provided for @authErrorInvalidVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'The verification code is invalid. Please try again.'**
  String get authErrorInvalidVerificationCode;

  /// No description provided for @authErrorInvalidContinueUri.
  ///
  /// In en, this message translates to:
  /// **'The continue URL is invalid. Please try again.'**
  String get authErrorInvalidContinueUri;

  /// No description provided for @authErrorInvalidCordovaConfiguration.
  ///
  /// In en, this message translates to:
  /// **'The Cordova configuration is invalid. Please try again.'**
  String get authErrorInvalidCordovaConfiguration;

  /// No description provided for @authErrorInvalidCustomToken.
  ///
  /// In en, this message translates to:
  /// **'The custom token is invalid. Please try again.'**
  String get authErrorInvalidCustomToken;

  /// No description provided for @authErrorInvalidDynamicLinkDomain.
  ///
  /// In en, this message translates to:
  /// **'The dynamic link domain is invalid. Please try again.'**
  String get authErrorInvalidDynamicLinkDomain;

  /// No description provided for @authErrorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'The email address you entered is invalid. Please try again.'**
  String get authErrorInvalidEmail;

  /// No description provided for @authErrorInvalidEmulatorScheme.
  ///
  /// In en, this message translates to:
  /// **'The emulator scheme is invalid. Please try again.'**
  String get authErrorInvalidEmulatorScheme;

  /// No description provided for @authErrorInvalidCredential.
  ///
  /// In en, this message translates to:
  /// **'The credential you provided is invalid. Please try again.'**
  String get authErrorInvalidCredential;

  /// No description provided for @authErrorInvalidMessagePayload.
  ///
  /// In en, this message translates to:
  /// **'The message payload is invalid. Please try again.'**
  String get authErrorInvalidMessagePayload;

  /// No description provided for @authErrorInvalidMultiFactorSession.
  ///
  /// In en, this message translates to:
  /// **'The multi-factor session is invalid. Please try again.'**
  String get authErrorInvalidMultiFactorSession;

  /// No description provided for @authErrorInvalidOAuthClientId.
  ///
  /// In en, this message translates to:
  /// **'The OAuth client ID is invalid. Please try again.'**
  String get authErrorInvalidOAuthClientId;

  /// No description provided for @authErrorInvalidOAuthProvider.
  ///
  /// In en, this message translates to:
  /// **'The OAuth provider is invalid. Please try again.'**
  String get authErrorInvalidOAuthProvider;

  /// No description provided for @authErrorInvalidActionCode.
  ///
  /// In en, this message translates to:
  /// **'The action code is invalid. Please try again.'**
  String get authErrorInvalidActionCode;

  /// No description provided for @authErrorUnauthorizedDomain.
  ///
  /// In en, this message translates to:
  /// **'You are not authorized to access this domain.'**
  String get authErrorUnauthorizedDomain;

  /// No description provided for @authErrorWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'The password you entered is incorrect. Please try again.'**
  String get authErrorWrongPassword;

  /// No description provided for @authErrorInvalidPersistenceType.
  ///
  /// In en, this message translates to:
  /// **'The persistence type is invalid. Please try again.'**
  String get authErrorInvalidPersistenceType;

  /// No description provided for @authErrorInvalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'The phone number you entered is invalid. Please try again with a valid phone number.'**
  String get authErrorInvalidPhoneNumber;

  /// No description provided for @authErrorInvalidProviderId.
  ///
  /// In en, this message translates to:
  /// **'The provider ID is invalid. Please try again.'**
  String get authErrorInvalidProviderId;

  /// No description provided for @authErrorInvalidRecipientEmail.
  ///
  /// In en, this message translates to:
  /// **'The recipient email address is invalid. Please try again.'**
  String get authErrorInvalidRecipientEmail;

  /// No description provided for @authErrorInvalidSender.
  ///
  /// In en, this message translates to:
  /// **'The sender is invalid. Please try again.'**
  String get authErrorInvalidSender;

  /// No description provided for @authErrorInvalidVerificationId.
  ///
  /// In en, this message translates to:
  /// **'The verification ID is invalid. Please try again.'**
  String get authErrorInvalidVerificationId;

  /// No description provided for @authErrorInvalidTenantId.
  ///
  /// In en, this message translates to:
  /// **'The tenant ID is invalid. Please try again.'**
  String get authErrorInvalidTenantId;

  /// No description provided for @authErrorMultiFactorInfoNotFound.
  ///
  /// In en, this message translates to:
  /// **'The multi-factor information was not found. Please try again.'**
  String get authErrorMultiFactorInfoNotFound;

  /// No description provided for @authErrorMultiFactorAuthRequired.
  ///
  /// In en, this message translates to:
  /// **'Multi-factor authentication is required to complete this.'**
  String get authErrorMultiFactorAuthRequired;

  /// No description provided for @authErrorMissingAndroidPkgName.
  ///
  /// In en, this message translates to:
  /// **'The Android package name is missing. Please try again.'**
  String get authErrorMissingAndroidPkgName;

  /// No description provided for @authErrorMissingAppCredential.
  ///
  /// In en, this message translates to:
  /// **'The app credentials are missing. Please try again.'**
  String get authErrorMissingAppCredential;

  /// No description provided for @authErrorAuthDomainConfigRequired.
  ///
  /// In en, this message translates to:
  /// **'The authentication domain configuration is required. Please try again.'**
  String get authErrorAuthDomainConfigRequired;

  /// No description provided for @authErrorMissingVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'The verification code is missing. Please try again.'**
  String get authErrorMissingVerificationCode;

  /// No description provided for @authErrorMissingContinueUri.
  ///
  /// In en, this message translates to:
  /// **'The continue URL is missing. Please try again.'**
  String get authErrorMissingContinueUri;

  /// No description provided for @authErrorMissingMultiFactorInfo.
  ///
  /// In en, this message translates to:
  /// **'The multi-factor information is missing. Please try again.'**
  String get authErrorMissingMultiFactorInfo;

  /// No description provided for @authErrorMissingMultiFactorSession.
  ///
  /// In en, this message translates to:
  /// **'The multi-factor session is missing. Please try again.'**
  String get authErrorMissingMultiFactorSession;

  /// No description provided for @authErrorMissingPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'The phone number is missing. Please try again.'**
  String get authErrorMissingPhoneNumber;

  /// No description provided for @authErrorMissingVerificationId.
  ///
  /// In en, this message translates to:
  /// **'The verification ID is missing. Please try again.'**
  String get authErrorMissingVerificationId;

  /// No description provided for @authErrorAppDeleted.
  ///
  /// In en, this message translates to:
  /// **'The app has been deleted. Please contact support for assistance.'**
  String get authErrorAppDeleted;

  /// No description provided for @authErrorAccountExistsWithDifferentCredential.
  ///
  /// In en, this message translates to:
  /// **'An account already exists with this email address. Please try logging in with a different method.'**
  String get authErrorAccountExistsWithDifferentCredential;

  /// No description provided for @authErrorNetworkRequestFailed.
  ///
  /// In en, this message translates to:
  /// **'The network request failed. Please check your internet connection and try again.'**
  String get authErrorNetworkRequestFailed;

  /// No description provided for @authErrorNullUser.
  ///
  /// In en, this message translates to:
  /// **'The user information is missing. Please try logging in again.'**
  String get authErrorNullUser;

  /// No description provided for @authErrorNoAuthEvent.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed due to missing information. Please try again.'**
  String get authErrorNoAuthEvent;

  /// No description provided for @authErrorNoSuchProvider.
  ///
  /// In en, this message translates to:
  /// **'The provider does not exist. Please try again.'**
  String get authErrorNoSuchProvider;

  /// No description provided for @authErrorOperationNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'You are not allowed to perform this operation.'**
  String get authErrorOperationNotAllowed;

  /// No description provided for @authErrorOperationNotSupportedInThisEnvironment.
  ///
  /// In en, this message translates to:
  /// **'This operation is not supported in your current environment.'**
  String get authErrorOperationNotSupportedInThisEnvironment;

  /// No description provided for @authErrorPopupBlocked.
  ///
  /// In en, this message translates to:
  /// **'The popup was blocked. Please allow popups and try again.'**
  String get authErrorPopupBlocked;

  /// No description provided for @authErrorPopupClosedByUser.
  ///
  /// In en, this message translates to:
  /// **'The popup was closed by the user.'**
  String get authErrorPopupClosedByUser;

  /// No description provided for @authErrorProviderAlreadyLinked.
  ///
  /// In en, this message translates to:
  /// **'The provider is already linked to another account. Please try again.'**
  String get authErrorProviderAlreadyLinked;

  /// No description provided for @authErrorQuotaExceeded.
  ///
  /// In en, this message translates to:
  /// **'The quota has been exceeded. Please try again later.'**
  String get authErrorQuotaExceeded;

  /// No description provided for @authErrorRedirectCancelledByUser.
  ///
  /// In en, this message translates to:
  /// **'The redirect was cancelled by the user.'**
  String get authErrorRedirectCancelledByUser;

  /// No description provided for @authErrorRedirectOperationPending.
  ///
  /// In en, this message translates to:
  /// **'The redirect operation is still pending. Please try again.'**
  String get authErrorRedirectOperationPending;

  /// No description provided for @authErrorRejectedCredential.
  ///
  /// In en, this message translates to:
  /// **'The credential was rejected. Please try again.'**
  String get authErrorRejectedCredential;

  /// No description provided for @authErrorSecondFactorAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'The second factor is already in use. Please try again.'**
  String get authErrorSecondFactorAlreadyInUse;

  /// No description provided for @authErrorMaximumSecondFactorCountExceeded.
  ///
  /// In en, this message translates to:
  /// **'The maximum number of second factors has been reached. Please try again.'**
  String get authErrorMaximumSecondFactorCountExceeded;

  /// No description provided for @authErrorTenantIdMismatch.
  ///
  /// In en, this message translates to:
  /// **'The tenant ID does not match. Please try again.'**
  String get authErrorTenantIdMismatch;

  /// No description provided for @authErrorTimeout.
  ///
  /// In en, this message translates to:
  /// **'The operation timed out. Please try again.'**
  String get authErrorTimeout;

  /// No description provided for @authErrorUserTokenExpired.
  ///
  /// In en, this message translates to:
  /// **'The user token has expired. Please try logging in again.'**
  String get authErrorUserTokenExpired;

  /// No description provided for @authErrorTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Please try again later.'**
  String get authErrorTooManyRequests;

  /// No description provided for @authErrorUnauthorizedContinueUri.
  ///
  /// In en, this message translates to:
  /// **'The continue URL is not authorized. Please try again.'**
  String get authErrorUnauthorizedContinueUri;

  /// No description provided for @authErrorUnsupportedFirstFactor.
  ///
  /// In en, this message translates to:
  /// **'The first factor is not supported. Please try again.'**
  String get authErrorUnsupportedFirstFactor;

  /// No description provided for @authErrorUnsupportedPersistenceType.
  ///
  /// In en, this message translates to:
  /// **'The persistence type is not supported. Please try again.'**
  String get authErrorUnsupportedPersistenceType;

  /// No description provided for @authErrorUnsupportedTenantOperation.
  ///
  /// In en, this message translates to:
  /// **'The tenant operation is not supported. Please try again.'**
  String get authErrorUnsupportedTenantOperation;

  /// No description provided for @authErrorUnverifiedEmail.
  ///
  /// In en, this message translates to:
  /// **'The email address has not been verified. Please check your email and follow the verification link.'**
  String get authErrorUnverifiedEmail;

  /// No description provided for @authErrorUserCancelled.
  ///
  /// In en, this message translates to:
  /// **'The user cancelled the operation.'**
  String get authErrorUserCancelled;

  /// No description provided for @authErrorUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'The user account was not found. Please try again.'**
  String get authErrorUserNotFound;

  /// No description provided for @authErrorUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'The user account has been disabled. Please contact support for assistance.'**
  String get authErrorUserDisabled;

  /// No description provided for @authErrorUserMismatch.
  ///
  /// In en, this message translates to:
  /// **'The user account does not match the information provided. Please try again.'**
  String get authErrorUserMismatch;

  /// No description provided for @authErrorUserSignedOut.
  ///
  /// In en, this message translates to:
  /// **'The user account has been signed out. Please log in again to continue.'**
  String get authErrorUserSignedOut;

  /// No description provided for @authErrorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'The password is too weak. Please choose a stronger password.'**
  String get authErrorWeakPassword;

  /// No description provided for @authErrorWebStorageUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Web storage is not supported in your current browser.'**
  String get authErrorWebStorageUnsupported;

  /// No description provided for @authErrorAlreadyInitialized.
  ///
  /// In en, this message translates to:
  /// **'Authentication has already been initialized.'**
  String get authErrorAlreadyInitialized;

  /// No description provided for @httpsErrorCancelled.
  ///
  /// In en, this message translates to:
  /// **'The action was cancelled or interrupted by the user.'**
  String get httpsErrorCancelled;

  /// No description provided for @httpsErrorInvalidArgument.
  ///
  /// In en, this message translates to:
  /// **'The request was not valid. Please check your input and try again.'**
  String get httpsErrorInvalidArgument;

  /// No description provided for @httpsErrorDeadlineExceeded.
  ///
  /// In en, this message translates to:
  /// **'The operation timed out. Please try again later.'**
  String get httpsErrorDeadlineExceeded;

  /// No description provided for @httpsErrorNotFound.
  ///
  /// In en, this message translates to:
  /// **'The requested resource could not be found.'**
  String get httpsErrorNotFound;

  /// No description provided for @httpsErrorAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'The resource already exists. Please choose a different name or ID.'**
  String get httpsErrorAlreadyExists;

  /// No description provided for @httpsErrorPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'You do not have permission to perform this action.'**
  String get httpsErrorPermissionDenied;

  /// No description provided for @httpsErrorResourceExhausted.
  ///
  /// In en, this message translates to:
  /// **'The resource has been exhausted. Please try again later or contact support.'**
  String get httpsErrorResourceExhausted;

  /// No description provided for @httpsErrorFailedPrecondition.
  ///
  /// In en, this message translates to:
  /// **'The request could not be completed due to a pre-existing condition. Please check your input and try again.'**
  String get httpsErrorFailedPrecondition;

  /// No description provided for @httpsErrorAborted.
  ///
  /// In en, this message translates to:
  /// **'The action was aborted. Please try again later.'**
  String get httpsErrorAborted;

  /// No description provided for @httpsErrorOutOfRange.
  ///
  /// In en, this message translates to:
  /// **'The request is outside the allowable range. Please check your input and try again.'**
  String get httpsErrorOutOfRange;

  /// No description provided for @httpsErrorUnimplemented.
  ///
  /// In en, this message translates to:
  /// **'This feature is not currently supported. Please check back later.'**
  String get httpsErrorUnimplemented;

  /// No description provided for @httpsErrorInternal.
  ///
  /// In en, this message translates to:
  /// **'An internal server error has occurred. Please try again later or contact support.'**
  String get httpsErrorInternal;

  /// No description provided for @httpsErrorUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The service is currently unavailable. Please try again later.'**
  String get httpsErrorUnavailable;

  /// No description provided for @httpsErrorDataLoss.
  ///
  /// In en, this message translates to:
  /// **'Data loss has occurred. Please contact support immediately.'**
  String get httpsErrorDataLoss;

  /// No description provided for @httpsErrorUnauthenticated.
  ///
  /// In en, this message translates to:
  /// **'You are not authenticated. Please log in or provide valid credentials to continue.'**
  String get httpsErrorUnauthenticated;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred. Please try again or contact support for assistance.'**
  String get unknownError;
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
