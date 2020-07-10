import 'package:WarmDoctor/config/API.dart';
import 'package:WarmDoctor/Http/ReqModel.dart';

/*
* 按时间线获取事件 - 请求
* */
class ArticleNewsReqModel extends ReqModel {
  @override
  String url() => API.timelineService;

  @override
  Map params() => {};

  Future data() => get();
}


class ArticleNewsModel {
  String summary;
  String sourceUrl;
  //int date;//新增
  int modifyTime;
  int createTime;
  int id;
  String provinceName;
  String title;
  int pubDate;
  String pubDateStr;
  String provinceId;
  String infoSource;

  ArticleNewsModel({
    this.summary,
    this.sourceUrl,
    //this.date,
    this.modifyTime,
    this.createTime,
    this.id,
    this.provinceName,
    this.title,
    this.pubDate,
    this.pubDateStr,
    this.provinceId,
    this.infoSource,
  });

  ArticleNewsModel.fromJson(Map<String, dynamic> json) {
    summary = json['summary'];
    sourceUrl = json['sourceUrl'];
    //date = json['date'];
    modifyTime = json['modifyTime'];
    createTime = json['createTime'];
    id = json['id'];
    provinceName = json['provinceName'];
    title = json['title'];
    pubDate = json['pubDate'];
    pubDateStr = json['pubDateStr'];
    provinceId = json['provinceId'];
    infoSource = json['infoSource'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['summary'] = this.summary;
    data['sourceUrl'] = this.sourceUrl;
    //data['date'] = this.date;
    data['modifyTime'] = this.modifyTime;
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['provinceName'] = this.provinceName;
    data['title'] = this.title;
    data['pubDate'] = this.pubDate;
    data['pubDateStr'] = this.pubDateStr;
    data['provinceId'] = this.provinceId;
    data['infoSource'] = this.infoSource;
    return data;
  }
}
