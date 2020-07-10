import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:WarmDoctor/api/entries_view_model.dart';
import 'package:WarmDoctor/api/home_view_model.dart';
import 'package:WarmDoctor/api/statistics_view_model.dart';
import 'package:WarmDoctor/common/common.dart';
import 'package:WarmDoctor/Widget/Card/home_card.dart';

import 'package:cached_network_image/cached_network_image.dart';
//import 'package:WarmDoctor/Widget/item/entries.dart';
import 'package:WarmDoctor/Widget/item/statics.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:WarmDoctor/Widget/item/titleview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<dynamic> data = new List();

  bool isReq = false;

  List entriesData = new List();

  StatisticsModel statisticsModel = new StatisticsModel();

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    Notice.addListener(NCOVActions.toTabBarIndex(), (index) {
      if (!listNoEmpty(data)) getData();
    });
    getData();
  }

  @override
  bool get wantKeepAlive => true;

  getData() {
//    homeListReqViewModel.getHome().then((v) {
//      setState(() {
//        data = v;
//        isReq = true;
//      });
//    });
    statisticsViewModel.getData().then((v) {
      setState(() => statisticsModel = v);
    });
//    entriesViewModel.getData().then((v) {
//      setState(() => entriesData = v);
//    });
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
    HomeListModel model = item;
    return new HomeCard(
      model,
      margin: EdgeInsets.only(
        left: 14.0,
        right: 14.0,
        top: model.id == data[0].id ? 20.0 : 10,
        bottom: model.id == data[data.length - 1].id ? 20.0 : 10,
      ),
      onTap: () {
        setState(() => model.isOpen = !model.isOpen);
      },
    );
  }

    @override
    Widget build(BuildContext context) {
      super.build(context);
      return new Scaffold(
        body: new SmartRefresher(
          controller: _refreshController,
          onRefresh: _refreshData,
          child: new ListView(
            children: <Widget>[
              new Space(),
              new TitleView(
                '全国统计',
                subTitle: '${timeHandle(statisticsModel?.modifyTime ?? 0)}',
              ),
              new Statics(statisticsModel ?? null),
              new Divider(),
              new Space(height: mainSpace / 2),
              new Visibility(
                visible: strNoEmpty(statisticsModel?.imgUrl ?? ''),
                child: new TitleView('疫情地图', subTitle: '数据来源：国家及各省市地区卫健委'),
              ),
              new Visibility(
                visible: strNoEmpty(statisticsModel?.imgUrl ?? ''),
                child: new Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: new CachedNetworkImage(
                      imageUrl: statisticsModel?.imgUrl ?? defImg),
                ),
              ),
              new Visibility(
                visible: listNoEmpty(statisticsModel?.dailyPics),
                child: new Column(
                  children: listNoEmpty(statisticsModel?.dailyPics)
                      ? statisticsModel.dailyPics.map((pics) {
                    return new CachedNetworkImage(imageUrl: pics);
                  }).toList()
                      : [],
                ),
              ),
//              new Space(),
//              new TitleView('诊疗'),
//              new Container(
//                margin: EdgeInsets.symmetric(horizontal: 10.0),
//                child: new Wrap(
//                  children: entriesData.map((item) {
//                    EntriesModel model = item;
//                    return Entries(model);
//                  }).toList(),
//                ),
//              ),
//              new TitleView('辟谣', subTitle: '消息数量：${data.length}'),
//              isReq
//                  ? listNoEmpty(data)
//                  ? new Column(
//                children: data.map(buildItem).toList(),
//              )
//                  : new Center(
//                child: new Text(
//                  '暂无数据',
//                  style: Theme
//                      .of(context)
//                      .textTheme
//                      .display1,
//                ),
//              )
//                  : new LoadingView(),
            ],
          ),
        ),
      );
    }
  }
