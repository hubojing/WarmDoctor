import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class CommunicationPage extends StatefulWidget{
  @override
  _CommunicationPageState createState() => _CommunicationPageState();
}

class _CommunicationPageState extends State<CommunicationPage>{
  @override
  Widget build(BuildContext context){
    List<Widget> titleContent = [];

    //titleContent.add(new Container(width: 50.0));
    return new WebviewScaffold(
      url:"https://hubojing.gitee.io/communicationpage/",

      // 登录的URL
      appBar: new AppBar(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: titleContent,
        ),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      withZoom: true,
      // 允许网页缩放
      withLocalStorage: true,
      // 允许LocalStorage
      withJavascript: true, // 允许执行js代码
    );

  }
}


