
part of 'video_type_list_model.dart';

VideoTypeListModel _$VideoTypeListModelFromJson(Map<String, dynamic> json) {
  return VideoTypeListModel(
    (json['typeList'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map((item) => VideoType.fromJson(item))
        .toList(),
    json['code'] as int,
    json['limit'] as String,
    (json['list'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map((item) => VideoInfo.fromJson(item))
        .toList(),
    json['msg'] as String,
    json['page'] as int,
    json['pageCount'] as int,
    json['total'] as int,
  );
}

Map<String, dynamic> _$VideoTypeListModelToJson(VideoTypeListModel instance) =>
    <String, dynamic>{
      'typeList': instance.typeList,
      'code': instance.code,
      'limit': instance.limit,
      'list': instance.list,
      'msg': instance.msg,
      'page': instance.page,
      'pageCount': instance.pageCount,
      'total': instance.total,
    };

VideoType _$VideoTypeFromJson(Map<String, dynamic> json) {
  return VideoType(
    typeId: json['typeId'] as int,
    typeName: json['typeName'] as String,
  );
}

Map<String, dynamic> _$VideoTypeToJson(VideoType instance) =>
    <String, dynamic>{
      'typeId': instance.typeId,
      'typeName': instance.typeName,
    };

VideoInfo _$VideoInfoFromJson(Map<String, dynamic> json) {
  return VideoInfo(
    typeId: json['typeId'] as int,
    typeName: json['typeName'] as String,
    vodEn: json['vodEn'] as String,
    vodId: json['vodId'] as int,
    vodName: json['vodName'] as String,
    vodPlayFrom: json['vodPlayFrom'] as String,
    vodRemarks: json['vodRemarks'] as String,
    vodTime: json['vodTime'] as String,
  );
}

Map<String, dynamic> _$VideoInfoToJson(VideoInfo instance) =>
    <String, dynamic>{
      'typeId': instance.typeId,
      'typeName': instance.typeName,
      'vodEn': instance.vodEn,
      'vodId': instance.vodId,
      'vodName': instance.vodName,
      'vodPlayFrom': instance.vodPlayFrom,
      'vodRemarks': instance.vodRemarks,
      'vodTime': instance.vodTime,
    };
