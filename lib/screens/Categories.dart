import 'package:flutter/material.dart';
import 'package:tag_me/components/CategoryCard.dart';
import 'package:tag_me/generated/i18n.dart';
import 'package:tag_me/repositories/CategoriesRepository.dart';
import 'package:tag_me/screens/CategoryDetail.dart';
import 'package:tag_me/service_locator/ServiceLocator.dart';

class Categories extends StatefulWidget {
  Categories({Key key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  var _categories = sl.get<CategoriesRepository>().categories.entries.toList();

  @override
  Widget build(BuildContext context) {
    _categories.shuffle();
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).categoriesTitle),
        ),
        body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this would produce 2 rows.
          crossAxisCount: 3,
          // Generate 100 Widgets that display their index in the List
          children: List.generate(_categories.length, (index) {
            var _title = _categories[index].key.toUpperCase();

            return CategoryCard(
              onPress: () => _onCategoryPressed(context, _title),
              title: _title,
              icon: _categories[index].value,
            );
          }),
        ));
  }

  void _onCategoryPressed(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryDetail(title)),
    );
  }
}
