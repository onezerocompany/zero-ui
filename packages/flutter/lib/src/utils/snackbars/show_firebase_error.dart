import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zero_ui/zero_ui.dart';

/// Shows a Firebase exception using the showError() function.
showFirebaseError(
  BuildContext context,
  WidgetRef ref, {
  FirebaseException? error,
  Map<String, String>? overrides,
}) {
  final t = ref.watch(zeroLocalizationsProvider);

  if (overrides?.containsKey(error?.code ?? "") == true) {
    showError(context, error: overrides![error?.code]!);
    return;
  }

  switch (error?.code) {
    case "admin-restricted-operation":
      showError(context, error: t.firebaseErrors.auth.AdminRestrictedOperation);
      break;
    case "argument-error":
      showError(context, error: t.firebaseErrors.auth.ArgumentError);
      break;
    case "app-not-installed":
      showError(context, error: t.firebaseErrors.auth.AppNotInstalled);
      break;
    case "captcha-check-failed":
      showError(context, error: t.firebaseErrors.auth.CaptchaCheckFailed);
      break;
    case "code-expired":
      showError(context, error: t.firebaseErrors.auth.CodeExpired);
      break;
    case "credential-already-in-use":
      showError(context, error: t.firebaseErrors.auth.CredentialAlreadyInUse);
      break;
    case "custom-token-mismatch":
      showError(context, error: t.firebaseErrors.auth.CustomTokenMismatch);
      break;
    case "requires-recent-login":
      showError(context, error: t.firebaseErrors.auth.RequiresRecentLogin);
      break;
    case "dynamic-link-not-activated":
      showError(context, error: t.firebaseErrors.auth.DynamicLinkNotActivated);
      break;
    case "email-change-needs-verification":
      showError(
        context,
        error: t.firebaseErrors.auth.EmailChangeNeedsVerification,
      );
      break;
    case "email-already-in-use":
      showError(context, error: t.firebaseErrors.auth.EmailAlreadyInUse);
      break;
    case "expired-action-code":
      showError(context, error: t.firebaseErrors.auth.ExpiredActionCode);
      break;
    case "cancelled-popup-request":
      showError(context, error: t.firebaseErrors.auth.CancelledPopupRequest);
      break;
    case "invalid-verification-code":
      showError(context, error: t.firebaseErrors.auth.InvalidVerificationCode);
      break;
    case "invalid-email":
      showError(context, error: t.firebaseErrors.auth.InvalidEmail);
      break;
    case "unauthorized-domain":
      showError(context, error: t.firebaseErrors.auth.UnauthorizedDomain);
      break;
    case "wrong-password":
      showError(context, error: t.firebaseErrors.auth.WrongPassword);
      break;
    case "invalid-phone-number":
      showError(context, error: t.firebaseErrors.auth.InvalidPhoneNumber);
      break;
    case "invalid-recipient-email":
      showError(context, error: t.firebaseErrors.auth.InvalidRecipientEmail);
      break;
    case "invalid-sender":
      showError(context, error: t.firebaseErrors.auth.InvalidSender);
      break;
    case "multi-factor-auth-required":
      showError(context, error: t.firebaseErrors.auth.MultiFactorAuthRequired);
      break;
    case "account-exists-with-different-credential":
      showError(
        context,
        error: t.firebaseErrors.auth.AccountExistsWithDifferentCredential,
      );
      break;
    case "network-request-failed":
      showError(context, error: t.firebaseErrors.auth.NetworkRequestFailed);
      break;
    case "operation-not-allowed":
      showError(context, error: t.firebaseErrors.auth.OperationNotAllowed);
      break;
    case "popup-blocked":
      showError(context, error: t.firebaseErrors.auth.PopupBlocked);
      break;
    case "provider-already-linked":
      showError(context, error: t.firebaseErrors.auth.ProviderAlreadyLinked);
      break;
    case "second-factor-already-in-use":
      showError(context, error: t.firebaseErrors.auth.SecondFactorAlreadyInUse);
      break;
    case "maximum-second-factor-count-exceeded":
      showError(
        context,
        error: t.firebaseErrors.auth.MaximumSecondFactorCountExceeded,
      );
      break;
    case "timeout":
      showError(context, error: t.firebaseErrors.auth.Timeout);
      break;
    case "too-many-requests":
      showError(context, error: t.firebaseErrors.auth.TooManyRequests);
      break;
    case "unverified-email":
      showError(context, error: t.firebaseErrors.auth.UnverifiedEmail);
      break;
    case "user-not-found":
      showError(context, error: t.firebaseErrors.auth.UserNotFound);
      break;
    case "user-disabled":
      showError(context, error: t.firebaseErrors.auth.UserDisabled);
      break;
    case "user-signed-out":
      showError(context, error: t.firebaseErrors.auth.UserSignedOut);
      break;
    case "weak-password":
      showError(context, error: t.firebaseErrors.auth.WeakPassword);
      break;
    case 'deadline-exceeded':
      showError(context, error: t.firebaseErrors.https.DeadlineExceeded);
      break;
    case 'not-found':
      showError(context, error: t.firebaseErrors.https.NotFound);
      break;
    case 'already-exists':
      showError(context, error: t.firebaseErrors.https.AlreadyExists);
      break;
    case 'permission-denied':
      showError(context, error: t.firebaseErrors.https.PermissionDenied);
      break;
    case 'unimplemented':
      showError(context, error: t.firebaseErrors.https.Unimplemented);
      break;
    case 'unavailable':
      showError(context, error: t.firebaseErrors.https.Unavailable);
      break;
    case 'unauthenticated':
      showError(context, error: t.firebaseErrors.https.Unauthenticated);
      break;
    default:
      showError(context, error: t.firebaseErrors.unknown);
      break;
  }
}
