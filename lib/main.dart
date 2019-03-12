import 'package:flutter/material.dart';
import 'package:tag_me/screens/BottomNavigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        routes: {
          "/start": (context) => BottomNavigationWidget()
        },
        theme: new ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.green,
          accentColor: Colors.teal[800],
          primaryTextTheme:
              Theme.of(context).primaryTextTheme.apply(bodyColor: Colors.white),
        ),
        home: BottomNavigationWidget()
    );
  }
}
