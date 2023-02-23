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

showSnackbar(
  BuildContext context, {
  required String title,
  String? subtitle,
  Color? color,
  dynamic icon,
}) {
  Color snackbarColor = color ?? Colors.black;
  Color textColor = snackbarColor.foreground;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: snackbarColor,
      content: Row(
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: icon is IconData
                  ? Icon(
                      icon: icon,
                      color: textColor,
                    )
                  : icon,
            ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: textColor,
                    ),
              ),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: textColor,
                      ),
                )
            ],
          ),
        ],
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
