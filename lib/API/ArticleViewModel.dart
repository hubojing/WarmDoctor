import 'dart:convert';
import 'dart:async' show Future;

import 'package:WarmDoctor/API/ArticleNewsModel.dart';
import 'package:WarmDoctor/Common/Check.dart';
import 'package:WarmDoctor/Http/ViewModel.dart';
import 'package:flutter/services.dart' show rootBundle;


ArticleNewsViewModel articleNewsViewModel = new ArticleNewsViewModel();

class ArticleNewsViewModel extends ViewModel {
  /*
  * 按时间线获取事件
  * */

  /*
  Future<String> loadAsset() async{
    return await rootBundle.loadString('assets/articleData.json');
  }
*/
  Future<dynamic> getTimeNews() async {
    final data = await ArticleNewsReqModel().data();
    //Future data = loadAsset();
    List list = new List();


   if (listNoEmpty(data)) {
    data.forEach((json) => list.add(ArticleNewsModel.fromJson(json)));
    }

    return Future.value(list);
  }
}
