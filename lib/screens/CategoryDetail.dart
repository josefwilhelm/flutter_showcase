import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tag_me/bloc/BlocProvider.dart';
import 'package:tag_me/bloc/HashtagBloc.dart';
import 'package:tag_me/components/CategoryDetailCard.dart';
import 'package:tag_me/components/HashtagChip.dart';
import 'package:tag_me/models/HashtagItem.dart';

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
  HashtagBloc _hashtagBloc;

  @override
  Widget build(BuildContext context) {
    _hashtagBloc = BlocProvider.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            InkWell(
              onTap: buildBottomSheet,
              child: Row(
                children: <Widget>[
                  StreamBuilder(
                      stream: _hashtagBloc.outTotalFavorites,
                      builder: (context, AsyncSnapshot<int> snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                              child: Text(
                            snapshot.data.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .apply(color: Colors.white),
                          ));
                        } else {
                          return Container();
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesomeIcons.hashtag,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Hero(
//                  tag: widget.title,
//                  child: Padding(
//                    padding: const EdgeInsets.all(12.0),
//                    child: Icon(
//                      widget.iconData,
//                      color: Theme.of(context).primaryColor,
//                      size: 48.0,
//                    ),
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(12.0),
//                  child: Text(
//                    widget.title,
//                    style: Theme.of(context)
//                        .textTheme
//                        .title
//                        .apply(color: Theme.of(context).primaryColor),
//                  ),
//                )
//              ],
//            ),
            Expanded(
                child: CategoryDetailCard(
              widget.title,
              widget.iconData,
            )),
          ],
        ));
  }

  void buildBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new Container(
              child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: "hashtag",
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        FontAwesomeIcons.hashtag,
                        color: Theme.of(context).primaryColor,
                        size: 48.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Hashtags",
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .apply(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
              new Text(
                'Here will be your hashtags ',
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 8.0),
              StreamBuilder(
                  stream: _hashtagBloc.outSelected,
                  builder:
                      (context, AsyncSnapshot<List<HashtagItem>> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                          child: _buildChips(snapshot.data, 1, _hashtagBloc));
                    } else {
                      return Container(
                          height: 100.0,
                          child: Center(child: Text("No hashtags selected")));
                    }
                  })
            ],
          ));
        });
  }

  Widget _buildChips(
      List<HashtagItem> hashtags, int i, HashtagBloc hashtagBloc) {
    List<Widget> _hashtagChips = List();

    hashtags.forEach((hashtag) {
      _hashtagChips.add(HashtagChip(hashtag, hashtagBloc));
    });

    return Wrap(
        spacing: 4.0, alignment: WrapAlignment.center, children: _hashtagChips);
  }
}
