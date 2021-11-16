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

