import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tag_me/generated/i18n.dart';
import 'package:tag_me/my_flutter_app_icons.dart';
import 'package:tag_me/screens/Categories.dart';
import 'package:tag_me/screens/Dashboard.dart';
import 'package:tag_me/screens/Profile.dart';

class BottomNavigationWidget extends StatefulWidget {
  _BottomNavigaitonWidgetState createState() => _BottomNavigaitonWidgetState();
}

class _BottomNavigaitonWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 1;
  final List<Widget> _widgets = [
    Dashboard(key: PageStorageKey("Dashboard")),
    Categories(key: PageStorageKey("Categories")),
    Profile(key: PageStorageKey("Profile")),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: _currentIndex,
          onTap: (int index) => setState(() => _currentIndex = index),
          items: [
            BottomNavigationBarItem(
              backgroundColor: color,
              icon: Icon(FontAwesomeIcons.home),
              title: new Text(S.of(context).categoriesTitle),
            ),
            BottomNavigationBarItem(
              backgroundColor: color,
              icon: Icon(MyFlutterApp.bear),
              title: new Text('Categories'),
            ),
            BottomNavigationBarItem(
                backgroundColor: color,
                icon: Icon(FontAwesomeIcons.user),
                title: Text('Profile')),
          ],
        ),
        body: PageStorage(
          bucket: bucket,
          child: _widgets[_currentIndex],
        ));
  }
}
