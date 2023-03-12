library zero_flutter;

// app
export 'src/app/app.dart';

// Router
export 'src/router/router.dart';

// scaffolding, pages and navigation bar
export 'src/scaffolding/multi_scaffold/multi_scaffold.dart';
export 'src/scaffolding/page/page.dart';
export 'src/scaffolding/adaptive/breakpoints.dart';
export 'src/scaffolding/omni_scaffold/omni_scaffold.dart';

// auth
export 'src/auth/auth_config.dart';
export 'src/auth/auth_state.dart';
export 'src/auth/sign_in/sign_in_screen.dart';
export 'src/auth/providers/apple/apple_sign_in_button.dart';
export 'src/auth/providers/google/google_sign_in_button.dart';

// content
export 'src/content/icons/icons.dart';
export 'src/content/buttons/buttons.dart';
export 'src/content/loader.dart';
export 'src/content/lists/list_item.dart';
export 'src/content/dialogs/dialog.dart';
export 'src/content/sections/section.dart';
export 'src/content/messages/inline_message.dart';
export 'src/content/forms/base/input_field.dart';

// picture related widgets
export 'src/pictures/cropper/cropper.dart';
export 'src/pictures/camera/camera_screen.dart';

// theme
export 'src/theme/theme.dart';

// utils
export 'src/utils/utils.dart';

// data
export 'src/data/firestore_serializable.dart';

// user profile
export 'src/profile/profile.dart';

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

// export riverpod + hooks
export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:riverpod_annotation/riverpod_annotation.dart'
    show riverpod, ProviderFor, Riverpod;
export 'package:flutter_hooks/flutter_hooks.dart';
