import 'package:flutter/material.dart';
import 'package:WarmDoctor/Common/Common.dart';
import 'package:WarmDoctor/Common/WinMedia.dart';
import 'package:WarmDoctor/Common/UI.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: winWidth(context),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new CircularProgressIndicator(),
          new Space(),
          new Text(
            '加载中',
            style: TextStyle(color: mainTextColor),
          ),
        ],
      ),
    );
  }
}
