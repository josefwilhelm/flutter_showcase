import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tag_me/bloc/BlocProvider.dart';
import 'package:tag_me/bloc/HashtagBloc.dart';
import 'package:tag_me/components/HashtagBottomSheet.dart';

class AppbarHashtagCountActionWidget extends StatelessWidget {
  AppbarHashtagCountActionWidget(this._buildContext);

  BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    HashtagBloc _hashtagBloc = BlocProvider.of(context);
    return Row(
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
        InkWell(
          onTap: () => _showBottomsheet(_buildContext),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              FontAwesomeIcons.hashtag,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  _showBottomsheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return HashtagBottomSheet(); // returns your BottomSheet widget
        });
  }
}
