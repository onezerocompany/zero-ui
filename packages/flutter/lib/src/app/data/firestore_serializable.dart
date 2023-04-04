import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:zero_ui/zero_ui.dart';

const firestoreSerializable = JsonSerializable(
  converters: [
    ...firestoreJsonConverters,
    FirestoreDateTimeRangeConverter(),
  ],
  createFieldMap: true,
  explicitToJson: true,
  checked: true,
  createToJson: true,
  createFactory: true,
  genericArgumentFactories: false,
  fieldRename: FieldRename.snake,
);
