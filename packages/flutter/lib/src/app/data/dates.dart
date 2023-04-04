import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:zero_ui/zero_ui.dart';

extension DateTimeRangeExtension on DateTimeRange {
  bool contains(DateTime dateTime) {
    return dateTime.isAfter(start) && dateTime.isBefore(end);
  }
}

/// A [JsonConverter] that adds support for [DateTimeRange] objects within ODM models.
class FirestoreDateTimeRangeConverter
    extends JsonConverter<DateTimeRange, Map<String, dynamic>> {
  const FirestoreDateTimeRangeConverter();
  @override
  DateTimeRange fromJson(Map<String, dynamic> json) => DateTimeRange(
        start: json['start'] is Timestamp
            ? json['start']!.toDate()
            : DateTime.parse(json['start']!),
        end: json['end'] is Timestamp
            ? json['end']!.toDate()
            : DateTime.parse(json['end']!),
      );

  @override
  Map<String, dynamic> toJson(DateTimeRange object) => {
        'start': Timestamp.fromDate(object.start),
        'end': Timestamp.fromDate(object.end),
      };
}
