import 'package:json_annotation/json_annotation.dart';

part 'video_detail_list_model.g.dart';


@JsonSerializable()
class VideoDetailListModel extends Object {

  @JsonKey(name: 'list')
  List<VideoDetail> list;

  VideoDetailListModel(this.list,);

  factory VideoDetailListModel.fromJson(Map<String, dynamic> srcJson) => _$VideoDetailListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoDetailListModelToJson(this);

}


@JsonSerializable()
class VideoDetail extends Object {

  @JsonKey(name: 'vod_id')
  late int vodId;

  @JsonKey(name: 'type_id')
  late int typeId;

  @JsonKey(name: 'type_id_1')
  late int typeId1;

  @JsonKey(name: 'group_id')
  late int groupId;

  @JsonKey(name: 'vod_name')
  late String vodName;

  @JsonKey(name: 'vod_sub')
  late String vodSub;

  @JsonKey(name: 'vod_en')
  late String vodEn;

  @JsonKey(name: 'vod_status')
  late int vodStatus;

  @JsonKey(name: 'vod_letter')
  late String vodLetter;

  @JsonKey(name: 'vod_color')
  late String vodColor;

  @JsonKey(name: 'vod_tag')
  late String vodTag;

  @JsonKey(name: 'vod_class')
  late String vodClass;

  @JsonKey(name: 'vod_pic')
  late String vodPic;

  @JsonKey(name: 'vod_pic_thumb')
  late String vodPicThumb;

  @JsonKey(name: 'vod_pic_slide')
  late String vodPicSlide;

  @JsonKey(name: 'vod_actor')
  late String vodActor;

  @JsonKey(name: 'vod_director')
  late String vodDirector;

  @JsonKey(name: 'vod_writer')
  late String vodWriter;

  @JsonKey(name: 'vod_behind')
  late String vodBehind;

  @JsonKey(name: 'vod_blurb')
  late String vodBlurb;

  @JsonKey(name: 'vod_remarks')
  late String vodRemarks;

  @JsonKey(name: 'vod_pubdate')
  late String vodPubdate;

  @JsonKey(name: 'vod_total')
  late int vodTotal;

  @JsonKey(name: 'vod_serial')
  late String vodSerial;

  @JsonKey(name: 'vod_tv')
  late String vodTv;

  @JsonKey(name: 'vod_weekday')
  late String vodWeekday;

  @JsonKey(name: 'vod_area')
  late String vodArea;

  @JsonKey(name: 'vod_lang')
  late String vodLang;

  @JsonKey(name: 'vod_year')
  late String vodYear;

  @JsonKey(name: 'vod_version')
  late String vodVersion;

  @JsonKey(name: 'vod_state')
  late String vodState;

  @JsonKey(name: 'vod_author')
  late String vodAuthor;

  @JsonKey(name: 'vod_jumpurl')
  late String vodJumpurl;

  @JsonKey(name: 'vod_tpl')
  late String vodTpl;

  @JsonKey(name: 'vod_tpl_play')
  late String vodTplPlay;

  @JsonKey(name: 'vod_tpl_down')
  late String vodTplDown;

  @JsonKey(name: 'vod_isend')
  late int vodIsend;

  @JsonKey(name: 'vod_lock')
  late int vodLock;

  @JsonKey(name: 'vod_level')
  late int vodLevel;

  @JsonKey(name: 'vod_copyright')
  late int vodCopyright;

  @JsonKey(name: 'vod_points')
  late int vodPoints;

  @JsonKey(name: 'vod_points_play')
  late int vodPointsPlay;

  @JsonKey(name: 'vod_points_down')
  late int vodPointsDown;

  @JsonKey(name: 'vod_hits')
  late int vodHits;

  @JsonKey(name: 'vod_hits_day')
  late int vodHitsDay;

  @JsonKey(name: 'vod_hits_week')
  late int vodHitsWeek;

  @JsonKey(name: 'vod_hits_month')
  late int vodHitsMonth;

  @JsonKey(name: 'vod_duration')
  late String vodDuration;

  @JsonKey(name: 'vod_up')
  late int vodUp;

  @JsonKey(name: 'vod_down')
  late int vodDown;

  @JsonKey(name: 'vod_score')
  late String vodScore;

  @JsonKey(name: 'vod_score_all')
  late int vodScoreAll;

  @JsonKey(name: 'vod_score_num')
  late int vodScoreNum;

  @JsonKey(name: 'vod_time')
  late String vodTime;

  @JsonKey(name: 'vod_time_add')
  late int vodTimeAdd;

  @JsonKey(name: 'vod_time_hits')
  late int vodTimeHits;

  @JsonKey(name: 'vod_time_make')
  late int vodTimeMake;

  @JsonKey(name: 'vod_trysee')
  late int vodTrysee;

  @JsonKey(name: 'vod_douban_id')
  late int vodDoubanId;

  @JsonKey(name: 'vod_douban_score')
  late String vodDoubanScore;

  @JsonKey(name: 'vod_reurl')
  late String vodReurl;

  @JsonKey(name: 'vod_rel_vod')
  late String vodRelVod;

  @JsonKey(name: 'vod_rel_art')
  late String vodRelArt;

  @JsonKey(name: 'vod_pwd')
  late String vodPwd;

  @JsonKey(name: 'vod_pwd_url')
  late String vodPwdUrl;

  @JsonKey(name: 'vod_pwd_play')
  late String vodPwdPlay;

  @JsonKey(name: 'vod_pwd_play_url')
  late String vodPwdPlayUrl;

  @JsonKey(name: 'vod_pwd_down')
  late String vodPwdDown;

  @JsonKey(name: 'vod_pwd_down_url')
  late String vodPwdDownUrl;

  @JsonKey(name: 'vod_content')
  late String vodContent;

  @JsonKey(name: 'vod_play_from')
  late String vodPlayFrom;

  @JsonKey(name: 'vod_play_server')
  late String vodPlayServer;

  @JsonKey(name: 'vod_play_note')
  late String vodPlayNote;

  @JsonKey(name: 'vod_play_url')
  late String vodPlayUrl;

  @JsonKey(name: 'vod_down_from')
  late String vodDownFrom;

  @JsonKey(name: 'vod_down_server')
  late String vodDownServer;

  @JsonKey(name: 'vod_down_note')
  late String vodDownNote;

  @JsonKey(name: 'vod_down_url')
  late String vodDownUrl;

  @JsonKey(name: 'vod_plot')
  late int vodPlot;

  @JsonKey(name: 'vod_plot_name')
  late String vodPlotName;

  @JsonKey(name: 'vod_plot_detail')
  late String vodPlotDetail;

  @JsonKey(name: 'type_name')
  late String typeName;

  VideoDetail(this.vodId,this.typeId,this.typeId1,this.groupId,this.vodName,this.vodSub,this.vodEn,this.vodStatus,this.vodLetter,this.vodColor,this.vodTag,this.vodClass,this.vodPic,this.vodPicThumb,this.vodPicSlide,this.vodActor,this.vodDirector,this.vodWriter,this.vodBehind,this.vodBlurb,this.vodRemarks,this.vodPubdate,this.vodTotal,this.vodSerial,this.vodTv,this.vodWeekday,this.vodArea,this.vodLang,this.vodYear,this.vodVersion,this.vodState,this.vodAuthor,this.vodJumpurl,this.vodTpl,this.vodTplPlay,this.vodTplDown,this.vodIsend,this.vodLock,this.vodLevel,this.vodCopyright,this.vodPoints,this.vodPointsPlay,this.vodPointsDown,this.vodHits,this.vodHitsDay,this.vodHitsWeek,this.vodHitsMonth,this.vodDuration,this.vodUp,this.vodDown,this.vodScore,this.vodScoreAll,this.vodScoreNum,this.vodTime,this.vodTimeAdd,this.vodTimeHits,this.vodTimeMake,this.vodTrysee,this.vodDoubanId,this.vodDoubanScore,this.vodReurl,this.vodRelVod,this.vodRelArt,this.vodPwd,this.vodPwdUrl,this.vodPwdPlay,this.vodPwdPlayUrl,this.vodPwdDown,this.vodPwdDownUrl,this.vodContent,this.vodPlayFrom,this.vodPlayServer,this.vodPlayNote,this.vodPlayUrl,this.vodDownFrom,this.vodDownServer,this.vodDownNote,this.vodDownUrl,this.vodPlot,this.vodPlotName,this.vodPlotDetail,this.typeName,);

  factory VideoDetail.fromJson(Map<String, dynamic> srcJson) => _$VideoDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoDetailToJson(this);

}


