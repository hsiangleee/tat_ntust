// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_config_version_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteConfigVersionInfo _$RemoteConfigVersionInfoFromJson(
        Map<String, dynamic> json) =>
    RemoteConfigVersionInfo(
      last: AndroidIosVersionInfo.fromJson(
          json['last_version'] as Map<String, dynamic>),
      lastVersionDetail: json['last_version_detail'] as String,
      isFocusUpdate: json['is_focus_update'] as bool,
      link:
          AndroidIosVersionInfo.fromJson(json['link'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteConfigVersionInfoToJson(
        RemoteConfigVersionInfo instance) =>
    <String, dynamic>{
      'is_focus_update': instance.isFocusUpdate,
      'last_version': instance.last,
      'last_version_detail': instance.lastVersionDetail,
      'link': instance.link,
    };

AndroidIosVersionInfo _$AndroidIosVersionInfoFromJson(
        Map<String, dynamic> json) =>
    AndroidIosVersionInfo(
      android: json['android'] as String,
      ios: json['ios'] as String,
    );

Map<String, dynamic> _$AndroidIosVersionInfoToJson(
        AndroidIosVersionInfo instance) =>
    <String, dynamic>{
      'android': instance.android,
      'ios': instance.ios,
    };
