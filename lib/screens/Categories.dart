import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  Categories({Key key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Categories"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              child: GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this would produce 2 rows.
                crossAxisCount: 3,
                // Generate 100 Widgets that display their index in the List
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color:
                          index % 3 == 0 ? Colors.red[200] : Colors.blue[200],
                      child: Center(
                        child: Text(
                          'Item $index',
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Flexible(
              child: GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this would produce 2 rows.
                crossAxisCount: 2,
                // Generate 100 Widgets that display their index in the List
                children: List.generate(2, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color:
                          index % 3 == 0 ? Colors.red[200] : Colors.blue[200],
                      child: Center(
                        child: Text(
                          'Item $index',
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Flexible(
              child: GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this would produce 2 rows.
                crossAxisCount: 3,
                // Generate 100 Widgets that display their index in the List
                children: List.generate(100, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color:
                          index % 3 == 0 ? Colors.red[200] : Colors.blue[200],
                      child: Center(
                        child: Text(
                          'Item $index',
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ));
  }
}
