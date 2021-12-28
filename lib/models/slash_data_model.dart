import 'package:json_annotation/json_annotation.dart';

part 'slash_data_model.g.dart';


@JsonSerializable()
class SlashDataModel extends Object {

  @JsonKey(name: 'imageUrl')
  String imageUrl;

  @JsonKey(name: 'landPageUrl')
  String landPageUrl;

  SlashDataModel(this.imageUrl,this.landPageUrl,);

  factory SlashDataModel.fromJson(Map<String, dynamic> srcJson) => _$SlashDataModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SlashDataModelToJson(this);

}



