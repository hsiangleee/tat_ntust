// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ap_tree_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APTreeJson _$APTreeJsonFromJson(Map<String, dynamic> json) {
  return APTreeJson(
    (json['apList'] as List)
        ?.map((e) =>
            e == null ? null : APListJson.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$APTreeJsonToJson(APTreeJson instance) =>
    <String, dynamic>{
      'apList': instance.apList,
    };

APListJson _$APListJsonFromJson(Map<String, dynamic> json) {
  return APListJson(
    name: json['name'] as String,
    url: json['url'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$APListJsonToJson(APListJson instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'type': instance.type,
    };
