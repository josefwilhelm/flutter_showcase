import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({
    this.onPress,
    @required this.title,
    @required this.icon,
  });

  final VoidCallback onPress;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 16),
              AutoSizeText(
                title,
                style: Theme.of(context).textTheme.subhead,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
