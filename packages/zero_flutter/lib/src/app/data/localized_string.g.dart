// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localized_string.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalizedString _$LocalizedStringFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'LocalizedString',
      json,
      ($checkedConvert) {
        final val = LocalizedString(
          translations: $checkedConvert(
              'translations',
              (v) => (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(k, e as String),
                  )),
        );
        return val;
      },
    );

const _$LocalizedStringFieldMap = <String, String>{
  'translations': 'translations',
};

Map<String, dynamic> _$LocalizedStringToJson(LocalizedString instance) =>
    <String, dynamic>{
      'translations': instance.translations,
    };
