typedef MailAction = Future<MailActionResponse> Function();
typedef MailActionWithEmail = Future<MailActionResponse> Function(
  String email,
);

class MailActionResponse {
  const MailActionResponse({
    required this.sent,
    this.inboxUrl,
  });

  final bool sent;
  final String? inboxUrl;
}
