import 'package:flutter/material.dart';
import 'package:tag_me/bloc/BlocProvider.dart';
import 'package:tag_me/bloc/HashtagBloc.dart';
import 'package:tag_me/components/CategoryDetailCard.dart';
import 'package:tag_me/components/CustomErrorWidget.dart';
import 'package:tag_me/models/HashtagItem.dart';
import 'package:tag_me/repositories/HashtagRepository.dart';
import 'package:tag_me/service_locator/ServiceLocator.dart';

class Favourites extends StatefulWidget {
  Favourites({Key key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  final _hashtagRepository = sl.get<HashtagRepository>();

  @override
  Widget build(BuildContext context) {
    HashtagBloc hashtagBloc = BlocProvider.of(context);

    return Column(children: <Widget>[
      StarredHeader(),
      SizedBox(height: 12.0),
      FutureBuilder(
          future: _hashtagRepository.favouriteHashtags,
          builder: (
            BuildContext context,
            AsyncSnapshot<Map<DateTime, List<HashtagItem>>> snapshot,
          ) {
            if (snapshot.hasData) {
              return HashtagChipCard(snapshot.data.values.elementAt(0));
            } else {
              return CustomErrorWidget(text: "No favourites yet");
            }
          })
    ]);
  }
}

class StarredHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Your Favourites",
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ));
  }
}
