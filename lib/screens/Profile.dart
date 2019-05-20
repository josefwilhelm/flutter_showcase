import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        "Coming soon...",
        style: Theme.of(context)
            .textTheme
            .title
            .apply(color: Theme.of(context).primaryColor),
      ),
    ));
  }
}
