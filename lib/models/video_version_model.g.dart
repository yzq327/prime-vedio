// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoVersionModel _$VideoVersionModelFromJson(Map<String, dynamic> json) {
  return VideoVersionModel(
    json['version'] as String,
    json['buildNumber'] as String,
    (json['content'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$VideoVersionModelToJson(VideoVersionModel instance) =>
    <String, dynamic>{
      'version': instance.version,
      'buildNumber': instance.buildNumber,
      'content': instance.content,
    };
