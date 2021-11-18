// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_type_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoTypeListModel _$VideoTypeListModelFromJson(Map<String, dynamic> json) {
  return VideoTypeListModel(
    (json['class'] as List)
        .map((e) => VideoType.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['code'] as int,
    json['limit'] as String,
    json['msg'] as String,
    json['page'] as int,
    json['pagecount'] as int,
    json['total'] as int,
  );
}

Map<String, dynamic> _$VideoTypeListModelToJson(VideoTypeListModel instance) =>
    <String, dynamic>{
      'typeList': instance.typeList,
      'code': instance.code,
      'limit': instance.limit,
      'msg': instance.msg,
      'page': instance.page,
      'pageCount': instance.pageCount,
      'total': instance.total,
    };

VideoType _$VideoTypeFromJson(Map<String, dynamic> json) {
  return VideoType(
    typeId: json['type_id'] as int,
    typeName: json['type_name'] as String,
  );
}

Map<String, dynamic> _$VideoTypeToJson(VideoType instance) => <String, dynamic>{
      'type_id': instance.typeId,
      'type_name': instance.typeName,
    };
