library zero_flutter;

// app
export 'src/app/app.dart';
export 'src/search_provider/search_provider.dart';

// scaffolding, pages and navigation bar
export 'src/scaffolding/multi_scaffold/multi_scaffold.dart';
export 'src/scaffolding/page/page.dart';
export 'src/scaffolding/adaptive/breakpoints.dart';
export 'src/scaffolding/omni_scaffold/omni_scaffold.dart';

// auth
export 'src/auth/sign_in_screen.dart';
export 'src/auth/providers/apple/apple_sign_in_button.dart';
export 'src/auth/providers/google/google_sign_in_button.dart';

// content
export 'src/content/icons/icons.dart';
export 'src/content/buttons/buttons.dart';
export 'src/content/loader.dart';
export 'src/content/lists/list_item.dart';
export 'src/content/dialogs/dialog.dart';
export 'src/content/sections/section.dart';
export 'src/content/inputs/inputs.dart';

// picture related widgets
export 'src/pictures/cropper/cropper.dart';
export 'src/pictures/camera/camera_screen.dart';

// theme
export 'src/theme/theme.dart';

// utils
export 'src/utils/utils.dart';

// localization
export 'l10n/zeroui_localizations.dart';

// data
export 'src/data/firestore_serializable.dart';
export 'src/data/user_permission.dart';

// export material for convenience
export 'package:flutter/material.dart'
    hide
        Colors,
        Icon,
        Icons,
        Page,
        Router,
        Dialog,
        showDialog,
        TextButton,
        IconButton;
