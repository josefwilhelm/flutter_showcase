import 'package:flutter/material.dart';
import 'package:tag_me/bloc/BlocProvider.dart';
import 'package:tag_me/bloc/HashtagBloc.dart';
import 'package:tag_me/components/CategoryDetailCard.dart';
import 'package:tag_me/models/HashtagItem.dart';
import 'package:tag_me/models/Insta.dart';
import 'package:tag_me/models/Predictions.dart';

class HashtagSearch extends StatefulWidget {
  HashtagSearch({Key key}) : super(key: key);

  @override
  _HashtagSearchState createState() => _HashtagSearchState();
}

class _HashtagSearchState extends State<HashtagSearch> {
  String _searchTerm;
  HashtagSearchResponse insta;
  Predictions predictions;
  HashtagBloc _hashtagBloc;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _hashtagBloc = BlocProvider.of(context);

    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
          TextField(
            onChanged: (text) {
              _searchTerm = text;
            },
          ),
          RaisedButton(
            child: Text("find Hashtag"),
            onPressed: () =>
                _hashtagBloc.getHashtagsforPictureLabel(_searchTerm),
          ),
          SizedBox(height: 12.0),
          Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder(
                  stream: _hashtagBloc.outPictureHashtag,
                  builder: (context,
                      AsyncSnapshot<List<HashtagItem>> snapshot) {
                    if (snapshot.hasData) {
                      return HashtagChipCard(snapshot.data);
                    } else {
                      return _searchTerm == null
                          ? Container()
                          : Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ),
        ]));
  }


}
