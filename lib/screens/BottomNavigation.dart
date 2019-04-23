import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tag_me/generated/i18n.dart';
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
    final color = Theme.of(context).primaryColor;

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          actions: <Widget>[
            Hero(
              tag: "hashtag",
              child: InkWell(
                onTap: buildBottomSheet,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    FontAwesomeIcons.hashtag,
                    color: Colors.white,
                  ),
                ),
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
                  )
                ],
              ),
              new Text(
                'Here will be your hashtags ',
                textAlign: TextAlign.left,
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
}
