import 'package:flutter/material.dart';
import 'package:tag_me/components/AppbarHashtagCountActionWidget.dart';
import 'package:tag_me/components/CategoryDetailCard.dart';

class CategoryDetail extends StatefulWidget {
  CategoryDetail(
    this.title,
    this.iconData,
  );

  final String title;
  final IconData iconData;

  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            Builder(
                builder: (context) => AppbarHashtagCountActionWidget(context)),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: CategoryDetailCard(
              widget.title,
              widget.iconData,
            )),
          ],
        ));
  }
}
