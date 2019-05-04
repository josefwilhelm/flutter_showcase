import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tag_me/bloc/BlocProvider.dart';
import 'package:tag_me/bloc/HashtagBloc.dart';
import 'package:tag_me/components/HashtagChip.dart';
import 'package:tag_me/components/RoundActionButton.dart';
import 'package:tag_me/generated/i18n.dart';
import 'package:tag_me/models/HashtagItem.dart';
import 'package:tag_me/my_flutter_app_icons.dart';
import 'package:tag_me/screens/Categories.dart';
import 'package:tag_me/screens/Home.dart';
import 'package:tag_me/screens/Profile.dart';
import 'package:tag_me/service_locator/ServiceLocator.dart';

class BottomNavigationWidget extends StatefulWidget {
  _BottomNavigaitonWidgetState createState() => _BottomNavigaitonWidgetState();
}

class _BottomNavigaitonWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 1;
  final List<Widget> _widgets = [
    Home(key: PageStorageKey("Dashboard")),
    Categories(key: PageStorageKey("Categories")),
    Profile(key: PageStorageKey("Profile")),
  ];

  HashtagBloc _hashtagBloc;

  VoidCallback _bottomSheetCallback;
//
//  @override
//  void initState() {
//    super.initState();
//    _bottomSheetCallback = _showBottomSheet;
//  }
//
//  void _showBottomSheet() {
//    setState(() {
//      _bottomSheetCallback = null;
//    });
//
//    buildBottomSheet();
//  }

  final PageStorageBucket bucket = PageStorageBucket();

  PersistentBottomSheetController<Null> _bottomSheet;

  @override
  Widget build(BuildContext context) {
    _hashtagBloc = BlocProvider.of(context);
    final color = Theme.of(context).primaryColor;

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          actions: <Widget>[
            Hero(
              tag: "hashtag",
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
                  InkWell(
                    onTap: buildBottomSheet,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        FontAwesomeIcons.hashtag,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: FancyBottomNavigation(
          initialSelection: _currentIndex,
          tabs: [
            TabData(
              iconData: MyFlutterApp.heart,
              title: "Home",
            ),
            TabData(
                iconData: MyFlutterApp.bear,
                title: S.of(context).categoriesTitle),
            TabData(
              iconData: MyFlutterApp.skull_2,
              title: "Profile",
            )
          ],
          onTabChangedListener: (position) {
            setState(() {
              _currentIndex = position;
            });
          },
        ),
        body: PageStorage(
          bucket: bucket,
          child: _widgets[_currentIndex],
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
                  }),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RoundActionButton(icon: Icon(FontAwesomeIcons.copy)),
                    RoundActionButton(icon: Icon(FontAwesomeIcons.share)),
                    RoundActionButton(icon: Icon(FontAwesomeIcons.heart)),
                  ],
                ),
              ),
            ],
          ));
        });

//        .closed
//        .whenComplete(() {
//          if (mounted) {
//            setState(() {
//              _bottomSheetCallback = _showBottomSheet;
//            });
//          }
//        });
  }

  _tapped() {
    print("josdfjkljskldf");
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
