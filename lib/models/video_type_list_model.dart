import 'package:json_annotation/json_annotation.dart';

part 'video_type_list_model.g.dart';

@JsonSerializable()
class VideoTypeListModel extends Object {
  @JsonKey(name: 'class')
  List<VideoType> typeList;

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'limit')
  String limit;

  @JsonKey(name: 'list')
  List<VideoInfo> list;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'pagecount')
  int pageCount;

  @JsonKey(name: 'total')
  int total;

  VideoTypeListModel(
      this.typeList,
      this.code,
      this.limit,
      this.list,
      this.msg,
      this.page,
      this.pageCount,
      this.total,
      );

  factory VideoTypeListModel.fromJson(Map<String, dynamic> srcJson) => _$VideoTypeListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoTypeListModelToJson(this);
}

@JsonSerializable()
class VideoType extends Object {
  @JsonKey(name: 'type_id')
  int typeId;

  @JsonKey(name: 'type_name')
  String typeName;

  VideoType({
    this.typeId,
    this.typeName,
  });

  factory VideoType.fromJson(Map<String, dynamic> srcJson) => _$VideoTypeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoTypeToJson(this);
}

@JsonSerializable()
class VideoInfo extends Object {
  @JsonKey(name: 'type_id')
  int typeId;

  @JsonKey(name: 'type_name')
  String typeName;

  @JsonKey(name: 'vod_en')
  String vodEn;

  @JsonKey(name: 'vod_id')
  int vodId;

  @JsonKey(name: 'vod_name')
  String vodName;

  @JsonKey(name: 'vod_play_from')
  String vodPlayFrom;

  @JsonKey(name: 'vod_remarks')
  String vodRemarks;

  @JsonKey(name: 'vod_time')
  String vodTime;

  VideoInfo({
    this.typeId,
    this.typeName,
    this.vodEn,
    this.vodId,
    this.vodName,
    this.vodPlayFrom,
    this.vodRemarks,
    this.vodTime,
  });

  factory VideoInfo.fromJson(Map<String, dynamic> srcJson) => _$VideoInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoInfoToJson(this);
}
