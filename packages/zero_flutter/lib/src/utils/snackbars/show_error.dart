import 'package:zero_flutter/zero_flutter.dart';

showError(
  BuildContext context, {
  required String error,
  IconData icon = Icons.error,
}) {
  showSnackbar(
    context,
    title: error,
    color: Colors.error,
    icon: icon,
  );
}
