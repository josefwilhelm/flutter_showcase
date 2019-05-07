import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tag_me/components/HashtagContainer.dart';

class HashtagBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BottomSheetHeader(),
          SizedBox(height: 8.0),
          HashtagContainer()
        ],
      )),
    );
  }
}

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            FontAwesomeIcons.hashtag,
            color: Theme.of(context).primaryColor,
            size: 48.0,
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
    );
  }
}
