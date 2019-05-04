import 'package:flutter/material.dart';

class RoundActionButton extends StatelessWidget {
  RoundActionButton({@required this.icon});

  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.0),
      onTap: () => print('hello'),
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
