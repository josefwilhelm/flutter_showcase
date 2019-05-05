import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              height: 12.0
            ),
            Text(
              "Loading",
              style: Theme.of(context).textTheme.title,
            )
          ],
        ),
      ),
    );
  }
}
