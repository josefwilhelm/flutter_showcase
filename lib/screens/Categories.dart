import 'package:flutter/material.dart';
import 'package:tag_me/components/CategoryCard.dart';
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
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Theme.of(context).primaryColor,
            Colors.white,
          ])),
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(_categories.length, (index) {
          var _title = _categories[index].key.toUpperCase();
          var _icon = _categories[index].value;

          return Hero(
            tag: _title,
            child: CategoryCard(
              onPress: () => _onCategoryPressed(context, _title, _icon),
              title: _title,
              icon: _icon,
            ),
          );
        }),
      ),
    ));
  }

  void _onCategoryPressed(BuildContext context, String title, IconData icon) {
//    Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => CategoryDetail(title, icon)),
//    );
    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 300),
            pageBuilder: (_, __, ___) => CategoryDetail(title, icon)));
  }
}
