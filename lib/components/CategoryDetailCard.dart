import 'package:flutter/material.dart';
import 'package:tag_me/bloc/BlocProvider.dart';
import 'package:tag_me/bloc/HashtagBloc.dart';
import 'package:tag_me/components/HashtagChip.dart';
import 'package:tag_me/models/HashtagItem.dart';

class CategoryDetailCard extends StatefulWidget {
  CategoryDetailCard(
    this.title,
    this.iconData,
  );

  final String title;
  final IconData iconData;

  @override
  _CategoryDetailCardState createState() => _CategoryDetailCardState();
}

class _CategoryDetailCardState extends State<CategoryDetailCard> {
//  Map _selected = Map();

  @override
  Widget build(BuildContext context) {
    HashtagBloc _hashtagBloc = BlocProvider.of(context);
    _hashtagBloc.getHashtagsForCategory(widget.title);
    return StreamBuilder(
        stream: _hashtagBloc.outHashtagCategories,
        builder: (context, AsyncSnapshot<List<HashtagItem>> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 8.0,
                  ),
                  Hero(
                    tag: widget.title,
                    child: Stack(
                      alignment: Alignment.center,
                      fit: StackFit.loose,
                      children: <Widget>[
                        Card(
                            child: _buildChips(snapshot.data, 1, _hashtagBloc)),
                        IgnorePointer(
                          child: Center(
                            child: Opacity(
                              opacity: 0.08,
                              child: Icon(
                                widget.iconData,
                                size: 120.0,
                                color: Colors.teal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            Center(child: Text(snapshot.error));
          } else {
            return Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      "Loading",
                      style: Theme.of(context).textTheme.title,
                    )
                  ],
                ),
              ),
            );
          }
        });
  }

  Widget _buildChips(
      List<HashtagItem> hashtags, int i, HashtagBloc hashtagBloc) {
    List<Widget> _hashtagChips = List();

//    hashtags.shuffle();

    var temp = i == 1 ? hashtags.sublist(0, 30) : hashtags.sublist(31, 60);

    temp.forEach((hashtag) {
      _hashtagChips.add(HashtagChip(hashtag, hashtagBloc));
    });

    return Wrap(
        spacing: 4.0, alignment: WrapAlignment.center, children: _hashtagChips);
  }
}
