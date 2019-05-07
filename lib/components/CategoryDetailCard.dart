import 'package:flutter/material.dart';
import 'package:tag_me/bloc/BlocProvider.dart';
import 'package:tag_me/bloc/HashtagBloc.dart';
import 'package:tag_me/components/CustomErrorWidget.dart';
import 'package:tag_me/components/CustomLoadingWidget.dart';
import 'package:tag_me/components/HashtagChip.dart';
import 'package:tag_me/models/HashtagItem.dart';

class CategoryDetailCard extends StatefulWidget {
  CategoryDetailCard(
    this.title,
    this.iconData,
  );

  final String title;
  final IconData iconData;

  @override
  _CategoryDetailCardState createState() => _CategoryDetailCardState();
}

class _CategoryDetailCardState extends State<CategoryDetailCard> {
  HashtagBloc _hashtagBloc;

  @override
  Widget build(BuildContext context) {
    _hashtagBloc = BlocProvider.of(context);
    _hashtagBloc.getHashtagsForCategory(widget.title);
    return StreamBuilder(
        stream: _hashtagBloc.outHashtagCategories,
        builder: (context, AsyncSnapshot<List<HashtagItem>> snapshot) {
          if (snapshot.hasData) {
            return _buildCard(snapshot.data);
          } else if (snapshot.hasError) {
            return new CustomErrorWidget(text: snapshot.error);
          } else {
            return CustomLoadingWidget();
          }
        });
  }

  Widget _buildCard(List<HashtagItem> data) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 8.0,
          ),
          Hero(
            tag: widget.title,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.loose,
              children: <Widget>[
                Card(child: HashtagChipCard(data)),
                IgnorePointer(
                  child: Center(
                    child: Opacity(
                      opacity: 0.08,
                      child: Icon(
                        widget.iconData,
                        size: 120.0,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
        ],
      ),
    );
  }
}

class HashtagChipCard extends StatelessWidget {
  HashtagChipCard(this.hashtags);

  final List<HashtagItem> hashtags;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Wrap(
          spacing: 4.0,
          alignment: WrapAlignment.center,
          children: hashtags.map((hashtag) => HashtagChip(hashtag)).toList()),
    );
  }
}
