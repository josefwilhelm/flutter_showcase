import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedActionButton extends StatelessWidget {
  RoundedActionButton(
      {@required this.iconData, @required this.onPress, @required this.text});

  final IconData iconData;
  final VoidCallback onPress;
  final String text;

  final Color textcolor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
        color: Theme.of(context).primaryColor,
        onPressed: onPress,
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(iconData, color: Colors.white,),
        ),
        label: text == null
            ? Container()
            : Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: textcolor),
              ));

//    return CupertinoButton(
//      color: Theme
//          .of(context)
//          .primaryColor,
//      onPressed: onPress,
//      child: Row(
//          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: icon,
//            ),
//            text == null
//                ? Container()
//                : Text(
//              text,
//              style: Theme
//                  .of(context)
//                  .textTheme
//                  .title
//                  .copyWith(color: textcolor),
//            ),
//          ]),);
//
//    return InkWell(
//      borderRadius: BorderRadius.circular(45.0),
//      onTap: onPress,
//      child: Container(
//        decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(45.0),
//          shape: BoxShape.rectangle,
////          border: Border.all(),
//          gradient: LinearGradient(
//              begin: Alignment.topLeft,
//              end: Alignment.bottomRight,
//              colors: [
//                Theme.of(context).primaryColor,
//                Colors.white,
//              ]),
//        ),
//        child: Padding(
//          padding: const EdgeInsets.all(16.0),
//          child: Row(
//            children: <Widget>[
//              icon,
//              SizedBox(width: 12.0),
//              text == null
//                  ? Container()
//                  : Text(
//                      text,
//                      style: Theme.of(context)
//                          .textTheme
//                          .title
//                          .copyWith(color: textcolor),
//                    )
//            ],
//          ),
//        ),
//      ),
//    );
  }
}
