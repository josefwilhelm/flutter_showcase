import 'package:flutter/material.dart';

class CategoryDetailCard extends StatelessWidget {
  CategoryDetailCard({
    @required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: <Widget>[
        HashtagChip("sjlkjlk"),
        HashtagChip("sdf sdf dsf "),
        HashtagChip("32   3 345"),
        HashtagChip("sdfsdf s df dsf df "),
        HashtagChip("dsf"),
        HashtagChip("sjlkjlk"),
        HashtagChip("sdf sdf dsf "),
        HashtagChip("32   3 345"),
        HashtagChip(" sf df"),
        HashtagChip("sjlkjlk"),
        HashtagChip("sdf sdf dsf "),
        HashtagChip("32   3 345"),
      ],
    );
  }

  Widget HashtagChip(String title) {
    return ChoiceChip(
      label: Text(title),
      selectedColor: Colors.amber,
      disabledColor: Colors.blue,
      backgroundColor: Colors.blueAccent,
      selected: true,
    );
  }
}
