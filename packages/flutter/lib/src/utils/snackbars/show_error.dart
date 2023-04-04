import 'package:zero_ui/zero_ui.dart';

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
