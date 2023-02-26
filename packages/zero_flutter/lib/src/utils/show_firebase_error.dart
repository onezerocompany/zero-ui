import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zero_flutter/zero_flutter.dart';

/// Shows a Firebase exception using the showError() function.
///
showFirebaseError(
  BuildContext context, {
  FirebaseException? error,
  Map<String, String>? overrides,
}) {
  if (overrides?.containsKey(error?.code ?? "") == true) {
    showError(context, error: overrides![error?.code]!);
    return;
  }

  final ZeroUIAppLocalizations l10n = ZeroUIAppLocalizations.of(context)!;
  switch (error?.code) {
    case "admin-restricted-operation":
      showError(context, error: l10n.authErrorAdminRestrictedOperation);
      break;
    case "argument-error":
      showError(context, error: l10n.authErrorArgumentError);
      break;
    case "app-not-authorized":
      showError(context, error: l10n.authErrorAppNotAuthorized);
      break;
    case "app-not-installed":
      showError(context, error: l10n.authErrorAppNotInstalled);
      break;
    case "captcha-check-failed":
      showError(context, error: l10n.authErrorCaptchaCheckFailed);
      break;
    case "code-expired":
      showError(context, error: l10n.authErrorCodeExpired);
      break;
    case "cors-unsupported":
      showError(context, error: l10n.authErrorCorsUnsupported);
      break;
    case "credential-already-in-use":
      showError(context, error: l10n.authErrorCredentialAlreadyInUse);
      break;
    case "custom-token-mismatch":
      showError(context, error: l10n.authErrorCustomTokenMismatch);
      break;
    case "requires-recent-login":
      showError(context, error: l10n.authErrorRequiresRecentLogin);
      break;
    case "dependent-sdk-initialized-before-auth":
      showError(
        context,
        error: l10n.authErrorDependentSdkInitializedBeforeAuth,
      );
      break;
    case "dynamic-link-not-activated":
      showError(context, error: l10n.authErrorDynamicLinkNotActivated);
      break;
    case "email-change-needs-verification":
      showError(context, error: l10n.authErrorEmailChangeNeedsVerification);
      break;
    case "email-already-in-use":
      showError(context, error: l10n.authErrorEmailAlreadyInUse);
      break;
    case "emulator-config-failed":
      showError(context, error: l10n.authErrorEmulatorConfigFailed);
      break;
    case "expired-action-code":
      showError(context, error: l10n.authErrorExpiredActionCode);
      break;
    case "cancelled-popup-request":
      showError(context, error: l10n.authErrorCancelledPopupRequest);
      break;
    case "internal-error":
      showError(context, error: l10n.authErrorInternalError);
      break;
    case "invalid-api-key":
      showError(context, error: l10n.authErrorInvalidApiKey);
      break;
    case "invalid-app-credential":
      showError(context, error: l10n.authErrorInvalidAppCredential);
      break;
    case "invalid-app-id":
      showError(context, error: l10n.authErrorInvalidAppId);
      break;
    case "invalid-user-token":
      showError(context, error: l10n.authErrorInvalidUserToken);
      break;
    case "invalid-auth-event":
      showError(context, error: l10n.authErrorInvalidAuthEvent);
      break;
    case "invalid-cert-hash":
      showError(context, error: l10n.authErrorInvalidCertHash);
      break;
    case "invalid-verification-code":
      showError(context, error: l10n.authErrorInvalidVerificationCode);
      break;
    case "invalid-continue-uri":
      showError(context, error: l10n.authErrorInvalidContinueUri);
      break;
    case "invalid-cordova-configuration":
      showError(context, error: l10n.authErrorInvalidCordovaConfiguration);
      break;
    case "invalid-custom-token":
      showError(context, error: l10n.authErrorInvalidCustomToken);
      break;
    case "invalid-dynamic-link-domain":
      showError(context, error: l10n.authErrorInvalidDynamicLinkDomain);
      break;
    case "invalid-email":
      showError(context, error: l10n.authErrorInvalidEmail);
      break;
    case "invalid-emulator-scheme":
      showError(context, error: l10n.authErrorInvalidEmulatorScheme);
      break;
    case "invalid-credential":
      showError(context, error: l10n.authErrorInvalidCredential);
      break;
    case "invalid-message-payload":
      showError(context, error: l10n.authErrorInvalidMessagePayload);
      break;
    case "invalid-multi-factor-session":
      showError(context, error: l10n.authErrorInvalidMultiFactorSession);
      break;

    case "invalid-oauth-client-id":
      showError(context, error: l10n.authErrorInvalidOAuthClientId);
      break;
    case "invalid-oauth-provider":
      showError(context, error: l10n.authErrorInvalidOAuthProvider);
      break;
    case "invalid-action-code":
      showError(context, error: l10n.authErrorInvalidActionCode);
      break;
    case "unauthorized-domain":
      showError(context, error: l10n.authErrorUnauthorizedDomain);
      break;
    case "wrong-password":
      showError(context, error: l10n.authErrorWrongPassword);
      break;
    case "invalid-persistence-type":
      showError(context, error: l10n.authErrorInvalidPersistenceType);
      break;
    case "invalid-phone-number":
      showError(context, error: l10n.authErrorInvalidPhoneNumber);
      break;
    case "invalid-provider-id":
      showError(context, error: l10n.authErrorInvalidProviderId);
      break;
    case "invalid-recipient-email":
      showError(context, error: l10n.authErrorInvalidRecipientEmail);
      break;
    case "invalid-sender":
      showError(context, error: l10n.authErrorInvalidSender);
      break;
    case "invalid-verification-id":
      showError(context, error: l10n.authErrorInvalidVerificationId);
      break;
    case "invalid-tenant-id":
      showError(context, error: l10n.authErrorInvalidTenantId);
      break;
    case "multi-factor-info-not-found":
      showError(context, error: l10n.authErrorMultiFactorInfoNotFound);
      break;
    case "multi-factor-auth-required":
      showError(context, error: l10n.authErrorMultiFactorAuthRequired);
      break;
    case "missing-android-pkg-name":
      showError(context, error: l10n.authErrorMissingAndroidPkgName);
      break;
    case "missing-app-credential":
      showError(context, error: l10n.authErrorMissingAppCredential);
      break;
    case "auth-domain-config-required":
      showError(context, error: l10n.authErrorAuthDomainConfigRequired);
      break;
    case "missing-verification-code":
      showError(context, error: l10n.authErrorMissingVerificationCode);
      break;
    case "missing-continue-uri":
      showError(context, error: l10n.authErrorMissingContinueUri);
      break;
    case "missing-multi-factor-info":
      showError(context, error: l10n.authErrorMissingMultiFactorInfo);
      break;
    case "missing-multi-factor-session":
      showError(context, error: l10n.authErrorMissingMultiFactorSession);
      break;
    case "missing-phone-number":
      showError(context, error: l10n.authErrorMissingPhoneNumber);
      break;
    case "missing-verification-id":
      showError(context, error: l10n.authErrorMissingVerificationId);
      break;
    case "app-deleted":
      showError(context, error: l10n.authErrorAppDeleted);
      break;
    case "account-exists-with-different-credential":
      showError(
        context,
        error: l10n.authErrorAccountExistsWithDifferentCredential,
      );
      break;
    case "network-request-failed":
      showError(context, error: l10n.authErrorNetworkRequestFailed);
      break;
    case "null-user":
      showError(context, error: l10n.authErrorNullUser);
      break;
    case "no-auth-event":
      showError(context, error: l10n.authErrorNoAuthEvent);
      break;
    case "no-such-provider":
      showError(context, error: l10n.authErrorNoSuchProvider);
      break;

    case "operation-not-allowed":
      showError(context, error: l10n.authErrorOperationNotAllowed);
      break;
    case "operation-not-supported-in-this-environment":
      showError(
        context,
        error: l10n.authErrorOperationNotSupportedInThisEnvironment,
      );
      break;
    case "popup-blocked":
      showError(context, error: l10n.authErrorPopupBlocked);
      break;
    case "popup-closed-by-user":
      showError(context, error: l10n.authErrorPopupClosedByUser);
      break;
    case "provider-already-linked":
      showError(context, error: l10n.authErrorProviderAlreadyLinked);
      break;
    case "quota-exceeded":
      showError(context, error: l10n.authErrorQuotaExceeded);
      break;
    case "redirect-cancelled-by-user":
      showError(context, error: l10n.authErrorRedirectCancelledByUser);
      break;
    case "redirect-operation-pending":
      showError(context, error: l10n.authErrorRedirectOperationPending);
      break;
    case "rejected-credential":
      showError(context, error: l10n.authErrorRejectedCredential);
      break;
    case "second-factor-already-in-use":
      showError(context, error: l10n.authErrorSecondFactorAlreadyInUse);
      break;
    case "maximum-second-factor-count-exceeded":
      showError(context, error: l10n.authErrorMaximumSecondFactorCountExceeded);
      break;
    case "tenant-id-mismatch":
      showError(context, error: l10n.authErrorTenantIdMismatch);
      break;
    case "timeout":
      showError(context, error: l10n.authErrorTimeout);
      break;
    case "user-token-expired":
      showError(context, error: l10n.authErrorUserTokenExpired);
      break;
    case "too-many-requests":
      showError(context, error: l10n.authErrorTooManyRequests);
      break;
    case "unauthorized-continue-uri":
      showError(context, error: l10n.authErrorUnauthorizedContinueUri);
      break;
    case "unsupported-first-factor":
      showError(context, error: l10n.authErrorUnsupportedFirstFactor);
      break;
    case "unsupported-persistence-type":
      showError(context, error: l10n.authErrorUnsupportedPersistenceType);
      break;
    case "unsupported-tenant-operation":
      showError(context, error: l10n.authErrorUnsupportedTenantOperation);
      break;
    case "unverified-email":
      showError(context, error: l10n.authErrorUnverifiedEmail);
      break;
    case "user-cancelled":
      showError(context, error: l10n.authErrorUserCancelled);
      break;
    case "user-not-found":
      showError(context, error: l10n.authErrorUserNotFound);
      break;
    case "user-disabled":
      showError(context, error: l10n.authErrorUserDisabled);
      break;
    case "user-mismatch":
      showError(context, error: l10n.authErrorUserMismatch);
      break;
    case "user-signed-out":
      showError(context, error: l10n.authErrorUserSignedOut);
      break;
    case "weak-password":
      showError(context, error: l10n.authErrorWeakPassword);
      break;
    case "web-storage-unsupported":
      showError(context, error: l10n.authErrorWebStorageUnsupported);
      break;
    case "already-initialized":
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
