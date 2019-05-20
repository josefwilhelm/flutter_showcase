import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tag_me/components/AppbarHashtagCountActionWidget.dart';
import 'package:tag_me/generated/i18n.dart';
import 'package:tag_me/my_flutter_app_icons.dart';
import 'package:tag_me/screens/Categories.dart';
import 'package:tag_me/screens/Favourites.dart';
import 'package:tag_me/screens/HashtagSearch.dart';
import 'package:tag_me/screens/Home.dart';
import 'package:tag_me/service_locator/ServiceLocator.dart';

class BottomNavigationWidget extends StatefulWidget {
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 1;

  final List<Widget> _widgets = [
    Home(key: PageStorageKey("Dashboard")),
    Categories(key: PageStorageKey("Categories")),
    HashtagSearch(key: PageStorageKey("Search")),
    Favourites(key: PageStorageKey("Starred")),
  ];

  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          actions: <Widget>[
            Builder(
                builder: (context) => AppbarHashtagCountActionWidget(context)),
          ],
        ),
        bottomNavigationBar: FancyBottomNavigation(
          initialSelection: _currentIndex,
          tabs: [
            TabData(
              iconData: FontAwesomeIcons.cameraRetro,
              title: "Home",
            ),
            TabData(
                iconData: MyFlutterApp.layers_3,
                title: S
                    .of(context)
                    .categoriesTitle),
            TabData(
              iconData: FontAwesomeIcons.search,
              title: "Search",
            ),

          ],
          onTabChangedListener: (position) {
            setState(() {
              _currentIndex = position;
            });
          },
        ),
        body: PageStorage(
          bucket: _bucket,
          child: _widgets[_currentIndex],
        ));
  }
}
