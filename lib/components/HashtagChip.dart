import 'package:flutter/material.dart';
import 'package:tag_me/bloc/BlocProvider.dart';
import 'package:tag_me/bloc/HashtagBloc.dart';
import 'package:tag_me/models/HashtagItem.dart';

class HashtagChip extends StatelessWidget {
  final HashtagItem _hashtagItem;
  HashtagChip(this._hashtagItem);

  @override
  Widget build(BuildContext context) {
    HashtagBloc _hashtagBloc = BlocProvider.of(context);
    var name = _hashtagItem.name;
    int posts = _hashtagItem.posts ~/ 1000;

    return ChoiceChip(
      padding: EdgeInsets.all(0.0),
      label: Text(
//        "$name - ${posts}k",
        "$name",
        style: TextStyle(
            fontSize: 11.0,
            color: _hashtagItem.selected
                ? Colors.white
                : Theme.of(context).primaryColor),
      ),
      selectedColor: Theme.of(context).primaryColor,
      disabledColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 2.0,
      selected: _hashtagItem.selected,
      onSelected: (bool selected) {
        _hashtagBloc.inAddSelected
            .add((HashtagItem(name, posts, selected: !_hashtagItem.selected)));
      },
    );
  }
}
