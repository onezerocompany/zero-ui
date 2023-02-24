import 'package:firebase_auth/firebase_auth.dart';
import 'package:zero_flutter/zero_flutter.dart';

/// Shows a Firebase exception using the showError() function.
///
showFirebaseError(
  BuildContext context,
  FirebaseException error, {
  Map<String, String>? overrides,
}) {
  if (overrides?.containsKey(error.code) == true) {
    showError(context, error: overrides![error.code]!);
    return;
  }

  final ZeroUIAppLocalizations l10n = ZeroUIAppLocalizations.of(context)!;
  switch (error.code) {
    case "auth/admin-restricted-operation":
      showError(context, error: l10n.authErrorAdminRestrictedOperation);
      break;
    case "auth/argument-error":
      showError(context, error: l10n.authErrorArgumentError);
      break;
    case "auth/app-not-authorized":
      showError(context, error: l10n.authErrorAppNotAuthorized);
      break;
    case "auth/app-not-installed":
      showError(context, error: l10n.authErrorAppNotInstalled);
      break;
    case "auth/captcha-check-failed":
      showError(context, error: l10n.authErrorCaptchaCheckFailed);
      break;
    case "auth/code-expired":
      showError(context, error: l10n.authErrorCodeExpired);
      break;
    case "auth/cors-unsupported":
      showError(context, error: l10n.authErrorCorsUnsupported);
      break;
    case "auth/credential-already-in-use":
      showError(context, error: l10n.authErrorCredentialAlreadyInUse);
      break;
    case "auth/custom-token-mismatch":
      showError(context, error: l10n.authErrorCustomTokenMismatch);
      break;
    case "auth/requires-recent-login":
      showError(context, error: l10n.authErrorRequiresRecentLogin);
      break;
    case "auth/dependent-sdk-initialized-before-auth":
      showError(
        context,
        error: l10n.authErrorDependentSdkInitializedBeforeAuth,
      );
      break;
    case "auth/dynamic-link-not-activated":
      showError(context, error: l10n.authErrorDynamicLinkNotActivated);
      break;
    case "auth/email-change-needs-verification":
      showError(context, error: l10n.authErrorEmailChangeNeedsVerification);
      break;
    case "auth/email-already-in-use":
      showError(context, error: l10n.authErrorEmailAlreadyInUse);
      break;
    case "auth/emulator-config-failed":
      showError(context, error: l10n.authErrorEmulatorConfigFailed);
      break;
    case "auth/expired-action-code":
      showError(context, error: l10n.authErrorExpiredActionCode);
      break;
    case "auth/cancelled-popup-request":
      showError(context, error: l10n.authErrorCancelledPopupRequest);
      break;
    case "auth/internal-error":
      showError(context, error: l10n.authErrorInternalError);
      break;
    case "auth/invalid-api-key":
      showError(context, error: l10n.authErrorInvalidApiKey);
      break;
    case "auth/invalid-app-credential":
      showError(context, error: l10n.authErrorInvalidAppCredential);
      break;
    case "auth/invalid-app-id":
      showError(context, error: l10n.authErrorInvalidAppId);
      break;
    case "auth/invalid-user-token":
      showError(context, error: l10n.authErrorInvalidUserToken);
      break;
    case "auth/invalid-auth-event":
      showError(context, error: l10n.authErrorInvalidAuthEvent);
      break;
    case "auth/invalid-cert-hash":
      showError(context, error: l10n.authErrorInvalidCertHash);
      break;
    case "auth/invalid-verification-code":
      showError(context, error: l10n.authErrorInvalidVerificationCode);
      break;
    case "auth/invalid-continue-uri":
      showError(context, error: l10n.authErrorInvalidContinueUri);
      break;
    case "auth/invalid-cordova-configuration":
      showError(context, error: l10n.authErrorInvalidCordovaConfiguration);
      break;
    case "auth/invalid-custom-token":
      showError(context, error: l10n.authErrorInvalidCustomToken);
      break;
    case "auth/invalid-dynamic-link-domain":
      showError(context, error: l10n.authErrorInvalidDynamicLinkDomain);
      break;
    case "auth/invalid-email":
      showError(context, error: l10n.authErrorInvalidEmail);
      break;
    case "auth/invalid-emulator-scheme":
      showError(context, error: l10n.authErrorInvalidEmulatorScheme);
      break;
    case "auth/invalid-credential":
      showError(context, error: l10n.authErrorInvalidCredential);
      break;
    case "auth/invalid-message-payload":
      showError(context, error: l10n.authErrorInvalidMessagePayload);
      break;
    case "auth/invalid-multi-factor-session":
      showError(context, error: l10n.authErrorInvalidMultiFactorSession);
      break;

    case "auth/invalid-oauth-client-id":
      showError(context, error: l10n.authErrorInvalidOAuthClientId);
      break;
    case "auth/invalid-oauth-provider":
      showError(context, error: l10n.authErrorInvalidOAuthProvider);
      break;
    case "auth/invalid-action-code":
      showError(context, error: l10n.authErrorInvalidActionCode);
      break;
    case "auth/unauthorized-domain":
      showError(context, error: l10n.authErrorUnauthorizedDomain);
      break;
    case "auth/wrong-password":
      showError(context, error: l10n.authErrorWrongPassword);
      break;
    case "auth/invalid-persistence-type":
      showError(context, error: l10n.authErrorInvalidPersistenceType);
      break;
    case "auth/invalid-phone-number":
      showError(context, error: l10n.authErrorInvalidPhoneNumber);
      break;
    case "auth/invalid-provider-id":
      showError(context, error: l10n.authErrorInvalidProviderId);
      break;
    case "auth/invalid-recipient-email":
      showError(context, error: l10n.authErrorInvalidRecipientEmail);
      break;
    case "auth/invalid-sender":
      showError(context, error: l10n.authErrorInvalidSender);
      break;
    case "auth/invalid-verification-id":
      showError(context, error: l10n.authErrorInvalidVerificationId);
      break;
    case "auth/invalid-tenant-id":
      showError(context, error: l10n.authErrorInvalidTenantId);
      break;
    case "auth/multi-factor-info-not-found":
      showError(context, error: l10n.authErrorMultiFactorInfoNotFound);
      break;
    case "auth/multi-factor-auth-required":
      showError(context, error: l10n.authErrorMultiFactorAuthRequired);
      break;
    case "auth/missing-android-pkg-name":
      showError(context, error: l10n.authErrorMissingAndroidPkgName);
      break;
    case "auth/missing-app-credential":
      showError(context, error: l10n.authErrorMissingAppCredential);
      break;
    case "auth/auth-domain-config-required":
      showError(context, error: l10n.authErrorAuthDomainConfigRequired);
      break;
    case "auth/missing-verification-code":
      showError(context, error: l10n.authErrorMissingVerificationCode);
      break;
    case "auth/missing-continue-uri":
      showError(context, error: l10n.authErrorMissingContinueUri);
      break;
    case "auth/missing-multi-factor-info":
      showError(context, error: l10n.authErrorMissingMultiFactorInfo);
      break;
    case "auth/missing-multi-factor-session":
      showError(context, error: l10n.authErrorMissingMultiFactorSession);
      break;
    case "auth/missing-phone-number":
      showError(context, error: l10n.authErrorMissingPhoneNumber);
      break;
    case "auth/missing-verification-id":
      showError(context, error: l10n.authErrorMissingVerificationId);
      break;
    case "auth/app-deleted":
      showError(context, error: l10n.authErrorAppDeleted);
      break;
    case "auth/account-exists-with-different-credential":
      showError(
        context,
        error: l10n.authErrorAccountExistsWithDifferentCredential,
      );
      break;
    case "auth/network-request-failed":
      showError(context, error: l10n.authErrorNetworkRequestFailed);
      break;
    case "auth/null-user":
      showError(context, error: l10n.authErrorNullUser);
      break;
    case "auth/no-auth-event":
      showError(context, error: l10n.authErrorNoAuthEvent);
      break;
    case "auth/no-such-provider":
      showError(context, error: l10n.authErrorNoSuchProvider);
      break;

    case "auth/operation-not-allowed":
      showError(context, error: l10n.authErrorOperationNotAllowed);
      break;
    case "auth/operation-not-supported-in-this-environment":
      showError(
        context,
        error: l10n.authErrorOperationNotSupportedInThisEnvironment,
      );
      break;
    case "auth/popup-blocked":
      showError(context, error: l10n.authErrorPopupBlocked);
      break;
    case "auth/popup-closed-by-user":
      showError(context, error: l10n.authErrorPopupClosedByUser);
      break;
    case "auth/provider-already-linked":
      showError(context, error: l10n.authErrorProviderAlreadyLinked);
      break;
    case "auth/quota-exceeded":
      showError(context, error: l10n.authErrorQuotaExceeded);
      break;
    case "auth/redirect-cancelled-by-user":
      showError(context, error: l10n.authErrorRedirectCancelledByUser);
      break;
    case "auth/redirect-operation-pending":
      showError(context, error: l10n.authErrorRedirectOperationPending);
      break;
    case "auth/rejected-credential":
      showError(context, error: l10n.authErrorRejectedCredential);
      break;
    case "auth/second-factor-already-in-use":
      showError(context, error: l10n.authErrorSecondFactorAlreadyInUse);
      break;
    case "auth/maximum-second-factor-count-exceeded":
      showError(context, error: l10n.authErrorMaximumSecondFactorCountExceeded);
      break;
    case "auth/tenant-id-mismatch":
      showError(context, error: l10n.authErrorTenantIdMismatch);
      break;
    case "auth/timeout":
      showError(context, error: l10n.authErrorTimeout);
      break;
    case "auth/user-token-expired":
      showError(context, error: l10n.authErrorUserTokenExpired);
      break;
    case "auth/too-many-requests":
      showError(context, error: l10n.authErrorTooManyRequests);
      break;
    case "auth/unauthorized-continue-uri":
      showError(context, error: l10n.authErrorUnauthorizedContinueUri);
      break;
    case "auth/unsupported-first-factor":
      showError(context, error: l10n.authErrorUnsupportedFirstFactor);
      break;
    case "auth/unsupported-persistence-type":
      showError(context, error: l10n.authErrorUnsupportedPersistenceType);
      break;
    case "auth/unsupported-tenant-operation":
      showError(context, error: l10n.authErrorUnsupportedTenantOperation);
      break;
    case "auth/unverified-email":
      showError(context, error: l10n.authErrorUnverifiedEmail);
      break;
    case "auth/user-cancelled":
      showError(context, error: l10n.authErrorUserCancelled);
      break;
    case "auth/user-not-found":
      showError(context, error: l10n.authErrorUserNotFound);
      break;
    case "auth/user-disabled":
      showError(context, error: l10n.authErrorUserDisabled);
      break;
    case "auth/user-mismatch":
      showError(context, error: l10n.authErrorUserMismatch);
      break;
    case "auth/user-signed-out":
      showError(context, error: l10n.authErrorUserSignedOut);
      break;
    case "auth/weak-password":
      showError(context, error: l10n.authErrorWeakPassword);
      break;
    case "auth/web-storage-unsupported":
      showError(context, error: l10n.authErrorWebStorageUnsupported);
      break;
    case "auth/already-initialized":
      showError(context, error: l10n.authErrorAlreadyInitialized);
      break;
    case 'cancelled':
      showError(context, error: l10n.httpsErrorCancelled);
      break;
    case 'invalid-argument':
      showError(context, error: l10n.httpsErrorInvalidArgument);
      break;
    case 'deadline-exceeded':
      showError(context, error: l10n.httpsErrorDeadlineExceeded);
      break;
    case 'not-found':
      showError(context, error: l10n.httpsErrorNotFound);
      break;
    case 'already-exists':
      showError(context, error: l10n.httpsErrorAlreadyExists);
      break;
    case 'permission-denied':
      showError(context, error: l10n.httpsErrorPermissionDenied);
      break;
    case 'resource-exhausted':
      showError(context, error: l10n.httpsErrorResourceExhausted);
      break;
    case 'failed-precondition':
      showError(context, error: l10n.httpsErrorFailedPrecondition);
      break;
    case 'aborted':
      showError(context, error: l10n.httpsErrorAborted);
      break;
    case 'out-of-range':
      showError(context, error: l10n.httpsErrorOutOfRange);
      break;
    case 'unimplemented':
      showError(context, error: l10n.httpsErrorUnimplemented);
      break;
    case 'internal':
      showError(context, error: l10n.httpsErrorInternal);
      break;
    case 'unavailable':
      showError(context, error: l10n.httpsErrorUnavailable);
      break;
    case 'data-loss':
      showError(context, error: l10n.httpsErrorDataLoss);
      break;
    case 'unauthenticated':
      showError(context, error: l10n.httpsErrorUnauthenticated);
      break;
    default:
      showError(context, error: l10n.unknownError);
      break;
  }
}
