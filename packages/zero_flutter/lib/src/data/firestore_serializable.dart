import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:json_annotation/json_annotation.dart';

const firestoreSerializable = JsonSerializable(
  converters: firestoreJsonConverters,
  createFieldMap: true,
  explicitToJson: true,
  checked: false,
  createToJson: true,
  genericArgumentFactories: false,
  anyMap: true,
  fieldRename: FieldRename.snake,
);
