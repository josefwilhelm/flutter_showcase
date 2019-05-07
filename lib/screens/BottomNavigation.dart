import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tag_me/bloc/BlocProvider.dart';
import 'package:tag_me/bloc/HashtagBloc.dart';
import 'package:tag_me/components/HashtagBottomSheet.dart';
import 'package:tag_me/generated/i18n.dart';
import 'package:tag_me/my_flutter_app_icons.dart';
import 'package:tag_me/screens/Categories.dart';
import 'package:tag_me/screens/Home.dart';
import 'package:tag_me/screens/Profile.dart';
import 'package:tag_me/screens/Favourites.dart';
import 'package:tag_me/service_locator/ServiceLocator.dart';

class BottomNavigationWidget extends StatefulWidget {
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 1;

  final List<Widget> _widgets = [
    Home(key: PageStorageKey("Dashboard")),
    Categories(key: PageStorageKey("Categories")),
    Favourites(key: PageStorageKey("Starred")),
    Profile(key: PageStorageKey("Profile")),
  ];

  HashtagBloc _hashtagBloc;

  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    _hashtagBloc = BlocProvider.of(context);

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
                    onTap: () => _showBottomsheet(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        FontAwesomeIcons.hashtag,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: FancyBottomNavigation(
          initialSelection: _currentIndex,
          tabs: [
            TabData(
              iconData: MyFlutterApp.camera_20,
              title: "Home",
            ),
            TabData(
                iconData: MyFlutterApp.bear,
                title: S.of(context).categoriesTitle),
            TabData(
              iconData: MyFlutterApp.heart,
              title: "Favourite",
            ),
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
          bucket: _bucket,
          child: _widgets[_currentIndex],
        ));
  }

  _showBottomsheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return HashtagBottomSheet(); // returns your BottomSheet widget
        });
  }
}
