import 'package:flutter/material.dart';
import 'package:WarmDoctor/api/book_view_model.dart';
import 'package:WarmDoctor/common/common.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
class BookCard extends StatelessWidget {
  final BookModel model;
  final EdgeInsetsGeometry margin;

  BookCard(this.model, {@required this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: lineColor, width: 0.2)),
      ),
      margin: margin,
      child: new FlatButton(
        onPressed: () {
          String url = model.url;
          launch(url);

        },
        child: new Row(
          children: <Widget>[
            new Visibility(
              visible: strNoEmpty(model?.cover_url),
              child: new ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: new CachedNetworkImage(
                  imageUrl: '${model.cover_url}',
                  height: 102.0,
                  width: 102.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new Space(),
            new Expanded(
              child: new Container(
                padding: EdgeInsets.symmetric(vertical: 25.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      '${model?.title ?? '未知'}',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                    new Space(height: 15.0),
                    new Text(
                      '${model?.abstract ?? '未知'}',
                      style: TextStyle(color: mainTextColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),


      ),
    );
  }
}