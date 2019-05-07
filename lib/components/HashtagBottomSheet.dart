import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:tag_me/bloc/BlocProvider.dart';
import 'package:tag_me/bloc/HashtagBloc.dart';
import 'package:tag_me/components/HashtagChip.dart';
import 'package:tag_me/components/RoundedActionButton.dart';
import 'package:tag_me/generated/i18n.dart';
import 'package:tag_me/models/HashtagItem.dart';
import 'package:tag_me/repositories/SharedPreferencesHelper.dart';
import 'package:tag_me/service_locator/ServiceLocator.dart';

class HashtagBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
          child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new BottomSheetHeader(),
          SizedBox(height: 8.0),
          new BottomSheetHashtagContainer(),
          BottomSheetButtonContainer(),
        ],
      )),
    );
  }
}

class BottomSheetButtonContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RoundedActionButton(
              iconData: FontAwesomeIcons.copy,
              onPress: () => _copyToClipboard(context),
              text: S.of(context).global_copy),
          RoundedActionButton(
              iconData: FontAwesomeIcons.shareAlt,
              onPress: _shareHashtags,
              text: S.of(context).global_share),
          RoundedActionButton(
            iconData: FontAwesomeIcons.heart,
            onPress: () => _saveHashtags(context),
            text: "Save",
          ),
        ]);
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

  void _saveHashtags(BuildContext context) {
    HashtagBloc _hashtagBloc = BlocProvider.of(context);
    sl.get<SharedPreferencesHelper>().setSavedHashtags(_hashtagBloc.selectedHashtags.values.toList());
  }
}

class BottomSheetHashtagContainer extends StatelessWidget {
  const BottomSheetHashtagContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HashtagBloc _hashtagBloc = BlocProvider.of(context);
    return StreamBuilder(
        stream: _hashtagBloc.outSelected,
        builder: (context, AsyncSnapshot<List<HashtagItem>> snapshot) {
          if (snapshot.hasData) {
            return Card(
              child: Wrap(
                  spacing: 4.0,
                  alignment: WrapAlignment.center,
                  children: snapshot.data
                      .map((hashtag) => HashtagChip(hashtag))
                      .toList()),
            );
          } else {
            return Container(
                height: 100.0,
                child: Center(child: Text("No hashtags selected")));
          }
        });
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
