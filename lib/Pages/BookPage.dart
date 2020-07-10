import 'dart:async';

import 'package:flutter/material.dart';
import 'package:WarmDoctor/Common/Common.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:WarmDoctor/api/book_view_model.dart';
import 'package:WarmDoctor/widget/card/BookCard.dart';

class BookPage extends StatefulWidget {
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  List data = new List();

  bool isReq = false;

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
    bookViewModel.getBook().then((v) {
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

  Widget buildItem(context, index) {
    BookModel model = data[index];
    return new BookCard(
      model,
      margin: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
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
          itemBuilder: buildItem,
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
