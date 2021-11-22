import 'package:json_annotation/json_annotation.dart';

part 'video_list_model.g.dart';

@JsonSerializable()
class VideoListModel extends Object {

  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'list')
  List<VideoInfo> list;

  VideoListModel(
      this.total,
      this.list,
  );

  factory VideoListModel.fromJson(Map<String, dynamic> srcJson) => _$VideoListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoListModelToJson(this);
}

@JsonSerializable()
class VideoInfo extends Object {

  @JsonKey(name: 'vod_id')
  int vodId;

  @JsonKey(name: 'vod_name')
  String vodName;

  @JsonKey(name: 'vod_pic')
  String vodPic;

  @JsonKey(name: 'vod_year')
  String vodYear;

  @JsonKey(name: 'vod_score')
  String vodScore;



  VideoInfo({
    required this.vodId,
    required this.vodName,
    required this.vodPic,
    required this.vodYear,
    required this.vodScore
  });

  factory VideoInfo.fromJson(Map<String, dynamic> srcJson) => _$VideoInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoInfoToJson(this);
}
