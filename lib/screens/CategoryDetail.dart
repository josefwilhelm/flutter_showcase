import 'package:flutter/material.dart';
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
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: widget.title,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      widget.iconData,
                      color: Theme.of(context).primaryColor,
                      size: 48.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    widget.title,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .apply(color: Theme.of(context).primaryColor),
                  ),
                )
              ],
            ),
            Expanded(
                child: CategoryDetailCard(
              title: widget.title,
            )),
          ],
        ));
  }
}
