import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:WarmDoctor/API/ArticleNewsModel.dart';
import 'package:WarmDoctor/Widget/View/LoadingView.dart';
import 'package:WarmDoctor/API/ArticleViewModel.dart';
import 'package:WarmDoctor/Common/Common.dart';
import 'package:WarmDoctor/Widget/Card/ArticleCard.dart';
//import 'package:WarmDoctor/AssetExtractor.java';

class ArticlePage extends StatefulWidget{
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>
    with AutomaticKeepAliveClientMixin{
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

/*
    void loadPy(File appFile,String appLib){
      //拷贝Python相关环境
      File pythonLibFile = new File(appFile, "python3.4.zip");
      if (!pythonLibFile.exists()) {
        copyFile(this, "python3.4.zip");
        copyFile(this, "_struct.cpython-34m.so");
        copyFile(this, "binascii.cpython-34m.so");
        copyFile(this, "time.cpython-34m.so");
        copyFile(this, "zlib.cpython-34m.so");
      }

      // 拷贝Python 代码
      copyFile(this, "calljava.py");
      copyFile(this, "test.py");

      try {
        // 加载Python解释器
        System.load(appLib + File.separator + "libpython3.4m.so");

        // 除了将代码直接拷贝，还支持将代码压缩为zip包，通过Install方法解压到指定路径
        InputStream dataSource = getAssets().open("py_code.zip");
        StarCoreFactoryPath.Install(dataSource, appFile.getPath(),true );
      } catch (Exception e) {
      e.printStackTrace();
      }

      /*----init starcore----*/
      StarCoreFactoryPath.StarCoreCoreLibraryPath = appLib;
      StarCoreFactoryPath.StarCoreShareLibraryPath = appLib;
      StarCoreFactoryPath.StarCoreOperationPath = appFile.getPath();

      StarCoreFactory starcore = StarCoreFactory.GetFactory();
      StarServiceClass Service = starcore._InitSimple("test", "123", 0, 0);
      SrvGroup = (StarSrvGroupClass) Service._Get("_ServiceGroup");
      Service._CheckPassword(false);

      /*----run python code----*/
      SrvGroup._InitRaw("python34", Service);
      StarObjectClass python = Service._ImportRawContext("python", "", false, "");
      // 设置Python模块加载路径
      python._Call("import", "sys");
      StarObjectClass pythonSys = python._GetObject("sys");
      StarObjectClass pythonPath = (StarObjectClass) pythonSys._Get("path");
      pythonPath._Call("insert", 0, appFile.getPath()+ File.separator +"python3.4.zip");
      pythonPath._Call("insert", 0, appLib);
      pythonPath._Call("insert", 0, appFile.getPath());

      //调用Python代码
      Service._DoFile("python", appFile.getPath() + "/py_code.py", "");
      long time = python._Calllong("get_time");
      Log.d("", "form python time="+time);

      Service._DoFile("python", appFile.getPath() + "/test.py", "");
      int result = python._Callint("add", 5, 2);
      Log.d("", "result="+result);

      python._Set("JavaClass", Log.class);
      Service._DoFile("python", appFile.getPath() + "/calljava.py", "");
    }

    private void copyFile(Context c, String Name) {
      File outfile = new File(c.getFilesDir(), Name);
      BufferedOutputStream outStream = null;
      BufferedInputStream inStream = null;

      try {
        outStream = new BufferedOutputStream(new FileOutputStream(outfile));
        inStream = new BufferedInputStream(c.getAssets().open(Name));

        byte[] buffer = new byte[1024 * 10];
        int readLen = 0;
        while ((readLen = inStream.read(buffer)) != -1) {
          outStream.write(buffer, 0, readLen);
        }
      } catch (IOException e) {
      e.printStackTrace();
      } finally {
      try {
      if (inStream != null) inStream.close();
      if (outStream != null) outStream.close();
      } catch (IOException e) {
      e.printStackTrace();
      }
      }
    }


    // Extract python files from assets
    AssetExtractor assetExtractor = new AssetExtractor(this);
    assetExtractor.removeAssets("python");
    assetExtractor.copyAssets("python");

    // Get the extracted assets directory
    String pyPath = assetExtractor.getAssetsDataDir() + "python";

*/

    bool isReq = false;

    List data = new List();

    void initState(){
      super.initState();
      Notice.addListener(NCOVActions.toTabBarIndex(),(index){
        if(!listNoEmpty(data)) getData();
      });
      getData();
    }

    bool get wantKeepAlive => true;

    getData() {
      articleNewsViewModel.getTimeNews().then((v) {
        setState(() {
          data = v;
          isReq = true;
        });
      });
    }

    Future<void> _refreshData() async {
      final Completer<Null> completer = new Completer<Null>();

      getData();

      new Future.delayed(new Duration(seconds: 2), () {
        completer.complete(null);
        _refreshController.refreshCompleted();
      });

      return completer.future;
    }

  Widget buildItem(item) {
    ArticleNewsModel model = item;
    bool isNew = model.id == data[0].id;
    return new ArticleCard(
      model,
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: isNew ? 10.0 : 10,
        bottom: model.id == data[data.length - 1].id ? 20.0 : 10,
      ),
      isNew: isNew,
    );
  }

    @override
    Widget build(BuildContext context) {
      super.build(context);
      return new Scaffold(
        body: new SmartRefresher(
          controller: _refreshController,
          onRefresh: _refreshData,
          child: isReq
              ? listNoEmpty(data)
              ? new ListView.builder(
            itemBuilder: (context, index) {
              ArticleNewsModel model = data[index];
              bool isNew = model.id == data[0].id;
              return new ArticleCard(
                model,
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: isNew ? 10.0 : 10,
                  bottom:
                  model.id == data[data.length - 1].id ? 20.0 : 10,
                ),
                isNew: isNew,
              );
            },
            itemCount: data.length,
          )
              : new Center(
            child: new Text(
              '暂无数据',
              style: Theme.of(context).textTheme.display1,
            ),
          )
              : new LoadingView(),
        ),
      );
    }
}