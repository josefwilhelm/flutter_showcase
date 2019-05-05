import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tag_me/bloc/BlocProvider.dart';
import 'package:tag_me/bloc/HashtagBloc.dart';
import 'package:tag_me/components/HashtagChip.dart';
import 'package:tag_me/components/RoundActionButton.dart';
import 'package:tag_me/models/HashtagItem.dart';
import 'package:share/share.dart';


class HashtagBottomSheet extends StatelessWidget {
  HashtagBloc _hashtagBloc;
  BuildContext _context;

  HashtagBottomSheet(this._context);
//    _hashtagBloc = BlocProvider.of(_context);
//  }

  @override
  Widget build(BuildContext context) {
    _hashtagBloc = BlocProvider.of(context);
    return buildBottomSheet(context);
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

  Widget buildBottomSheet(BuildContext context) {
          return Scaffold(
            body: new Container(
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
                    }),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Builder(
                    builder: (bottomsheetContext) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RoundActionButton(icon: Icon(FontAwesomeIcons.copy), onPress: () => _copyToClipboard(bottomsheetContext), ),
                        RoundActionButton(icon: Icon(FontAwesomeIcons.share), onPress: _shareHashtags,),
                        RoundActionButton(icon: Icon(FontAwesomeIcons.heart)),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          );
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(new ClipboardData(text: "Test if copy works"));
//    Navigator.pop(_context); // hiding bottom sheet



        Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Hashtags successfully copied :)'),
      duration: Duration(seconds: 3),
    ));
  }

  void _shareHashtags() {
    Share.share("Test if copy works");
  }
}

