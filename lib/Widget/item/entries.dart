import 'package:flutter/material.dart';
import 'package:WarmDoctor/api/entries_view_model.dart';
import 'package:WarmDoctor/common/common.dart';

class Entries extends StatelessWidget {
  final EntriesModel model;

  Entries(this.model);

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: (winWidth(context) - 20) / 3,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: new FlatButton(
//        onPressed: () => routePush(
//          new WebViewPage(model?.linkUrl ?? 'http://book.flutterj.com/',
//              '${model?.configName ?? '未知'}'),
//        ),
        child: new Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: new Column(
            children: <Widget>[
              new Image.asset('${model.icon}', width: 50.0, height: 50.0),
              new Padding(
                padding: EdgeInsets.only(top: 2.0),
                child: new Text(
                  '${model.configName}',
                  style: TextStyle(fontSize: 12.0, color: mainTextColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
