import 'package:flutter/material.dart';

class RoundActionButton extends StatelessWidget {
  RoundActionButton({@required this.icon, @required this.onPress});

  final Icon icon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(45.0),
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: icon,
        ),
      ),
    );
  }
}
