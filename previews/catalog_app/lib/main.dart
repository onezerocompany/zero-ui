import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:zero_ui/zero_ui.dart';

import 'config.dart';
import 'firebase_options.dart';

Uint8List? testImageBytes;

final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
final functions = FirebaseFunctions.instanceFor(region: "europe-west1");

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // use firebase auth emulator when on debug
  if (kDebugMode) {
    print("using firebase emulators");
    await auth.useAuthEmulator('10.0.0.15', 5001);
    firestore.useFirestoreEmulator("10.0.0.15", 5002);
    functions.useFunctionsEmulator(
      "10.0.0.15",
      5003,
    );
  }

  testImageBytes = (await rootBundle.load('assets/images/dalle-static.png'))
      .buffer
      .asUint8List();

  globalContainer
      .read(currentAppConfigBuilderProvider.notifier)
      .set(configBuilder);

  runApp(const ZeroApp());
}
