import 'package:json_annotation/json_annotation.dart';

part 'video_version_model.g.dart';


@JsonSerializable()
class VideoVersionModel extends Object {

  @JsonKey(name: 'version')
  String version;

  @JsonKey(name: 'buildNumber')
  String buildNumber;

  @JsonKey(name: 'content')
  List<String> content;

  VideoVersionModel(this.version,this.buildNumber,this.content,);

  factory VideoVersionModel.fromJson(Map<String, dynamic> srcJson) => _$VideoVersionModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoVersionModelToJson(this);

}


