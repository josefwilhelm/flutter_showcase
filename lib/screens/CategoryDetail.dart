import 'package:flutter/material.dart';
import 'package:tag_me/components/CategoryDetailCard.dart';

class CategoryDetail extends StatefulWidget {
  CategoryDetail(
    this.title,
  );

  final String title;

  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Row(
          children: <Widget>[
            Expanded(
                child: CategoryDetailCard(
              title: widget.title,
            )),
          ],
        ));
  }
}
