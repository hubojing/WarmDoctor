import 'package:WarmDoctor/config/api.dart';
import 'package:WarmDoctor/http/ReqModel.dart';

/*
* 最新知识百科 - 请求
* */
class BookReqModel extends ReqModel {
  @override
  String url() => "https://book.feelyou.top/search/心理";
  @override
  Map params() => {};

  Future data() => get();
}

class BookModel {
  String cover_url;
  String url;
  String abstract;
  String title;

  BookModel.fromJson(Map<String, dynamic> json) {
    cover_url = json["cover_url"];
    url = json['url'];
    abstract = json['abstract'];
    title = json['title'];
  }

  List<dynamic> toJson() {
    final List<dynamic> data = new List<dynamic>();
    data[0]['cover_url'] = this.cover_url;
    data[0]['url'] = this.url;
    data[0]['abstract'] = this.abstract;
    data[0]['title'] = this.title;
    return data;
  }
}
