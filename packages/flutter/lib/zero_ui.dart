library zero_ui;

export 'src/utils/utils.dart';
export 'src/app/app.dart';
export 'src/components/components.dart';

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
export 'package:hooks_riverpod/hooks_riverpod.dart';
