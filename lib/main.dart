import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tag_me/bloc/BlocProvider.dart';
import 'package:tag_me/bloc/HashtagBloc.dart';
import 'package:tag_me/generated/i18n.dart';
import 'package:tag_me/repositories/CategoriesRepository.dart';
import 'package:tag_me/repositories/HashtagRepository.dart';
import 'package:tag_me/screens/BottomNavigation.dart';
import 'package:tag_me/service_locator/ServiceLocator.dart';

void main() {
  sl.registerSingleton(CategoriesRepository());
  sl.registerSingleton(HashtagRepository());

  runApp(BlocProvider(
    bloc: HashtagBloc(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      onGenerateTitle: (BuildContext context) => S.of(context).appTitle,
      routes: {"/start": (context) => BottomNavigationWidget()},
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.pink[200],
        accentColor: Colors.brown[400],
        primaryTextTheme:
            Theme.of(context).primaryTextTheme.apply(bodyColor: Colors.white),
      ),
      home: Scaffold(body: BottomNavigationWidget()),
      localizationsDelegates: [
        // https://github.com/long1eu/flutter_i18n
        S.delegate,
        // You need to add them if you are using the material library.
        // The material components usses this delegates to provide default
        // localization
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      // ...
    );
  }
}
