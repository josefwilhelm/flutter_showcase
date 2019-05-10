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

  bool delay = false;

  @override
  initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        delay = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _hashtagBloc = BlocProvider.of(context);

    return
      Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            autofocus: true,
            onChanged: (text) {
              _searchTerm = text;
            },
          ),
        ),
        RaisedButton.icon(
            color: Theme
                .of(context)
                .primaryColor,
            icon: Icon(Icons.search, color: Colors.white,),
            label: Text("find Hashtag", style: Theme
                .of(context)
                .textTheme
                .button
                .copyWith(color: Colors.white),),
            onPressed: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              _hashtagBloc.getHashtagsforPictureLabel(_searchTerm);
            }
          ),
          SizedBox(height: 12.0),
          Expanded(
            child: SingleChildScrollView(
              child: delay == false ? Container() : StreamBuilder(
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
      ]);
  }


}
