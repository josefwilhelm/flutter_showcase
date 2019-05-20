

import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    @required this.text,
    Key key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error_outline,
            size: 48.0,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(height: 12.0),
          Center(
              child: Text(
                text,
                style: Theme.of(context).textTheme.subhead,
              )),
        ],
      ),
    );
  }
}
