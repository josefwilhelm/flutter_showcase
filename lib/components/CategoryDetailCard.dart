import 'package:flutter/material.dart';
import 'package:tag_me/bloc/HashtagBloc.dart';
import 'package:tag_me/models/Insta.dart';

class CategoryDetailCard extends StatefulWidget {
  CategoryDetailCard({
    @required this.title,
  });

  final String title;

  @override
  _CategoryDetailCardState createState() => _CategoryDetailCardState();
}

class _CategoryDetailCardState extends State<CategoryDetailCard> {
  HashtagBloc _hashtagBloc = HashtagBloc();

  Map _selected = Map();

  void initState() {
    super.initState();
    _hashtagBloc.getHashtags(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _hashtagBloc.subject,
        builder: (context, AsyncSnapshot<HashtagSearchResponse> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 8.0,
                  ),
                  Card(child: _buildChips(snapshot.data.hashtags, 1)),
                  SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            );
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

  Widget _buildChips(List<HashtagElement> hashtags, int i) {
    List<Widget> _hashtagChips = List();

//    hashtags.shuffle();

    var temp = i == 1 ? hashtags.sublist(0, 30) : hashtags.sublist(31, 60);

    temp.forEach((hashtag) {
      _hashtagChips.add(chip(hashtag.hashtag));
    });

    return Wrap(
        spacing: 4.0, alignment: WrapAlignment.center, children: _hashtagChips);
  }

  Widget chip(HashtagHashtag hashtag) {
    var name = hashtag.name;
    int posts = hashtag.mediaCount ~/ 1000;
    if (!_selected.containsKey(name)) _selected[name] = false;

    return ChoiceChip(
      padding: EdgeInsets.all(0.0),
      label: Text(
//        "$name - ${posts}k",
        "$name",
        style: TextStyle(
            fontSize: 11.0,
            color: _selected.containsKey(name) == true
                ? Colors.white
                : Theme.of(context).primaryColor),
      ),
      selectedColor: Theme.of(context).primaryColor,
      selected: _selected[name],
      onSelected: (bool selected) {
        setState(() {
          _selected[hashtag.name] = selected;
        });
      },
    );
  }
}

//class HashtagChip extends StatelessWidget {
//  HashtagChip({
//    @required this.hashtag,
//  });
//
//  final HashtagHashtag hashtag;
//
//  @override
//  Widget build(BuildContext context) {
//    var name = hashtag.name;
//    var posts = hashtag.mediaCount;
//    if (!_selected.containsKey(name)) _selected[name] = false;
//
//    return ChoiceChip(
//      label: Text(
//        title,
//        style: TextStyle(color: Colors.white),
//      ),
//      selectedColor: Colors.brown[200],
//      disabledColor: Colors.blue,
//      backgroundColor: Colors.blueAccent,
//      selected: true,
//    );
//  }
//}
