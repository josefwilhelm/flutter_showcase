import 'package:flutter/material.dart';
import 'package:tag_me/models/Insta.dart';
import 'package:tag_me/models/Predictions.dart';

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class Categories extends StatefulWidget {
  Categories({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  String _searchTerm;
  String _location;
  Insta insta;
  Predictions predictions;
  String apikey = "AIzaSyC-4Y5uHkRX4FbPgp-HcfS7ro4YBXeHV30";
  var googleUrl =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%url&key=AIzaSyC-4Y5uHkRX4FbPgp-HcfS7ro4YBXeHV30";

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        TextField(
          onChanged: (text) {
            _searchTerm = text;
            _onButtonPressed();
          },
        ),
        RaisedButton(
          child: Text("find Hashtag"),
          onPressed: _onButtonPressed,
        ),
        TextField(
          onChanged: (text) {
            _location = text;
          },
        ),
        RaisedButton(child: Text("Search location"), onPressed: searchLocation),
        predictions == null ? Text("no locations") : buildLocationList(),
        insta == null ? Text("no hashtags") : _buildList(),
      ]),
    );
  }

  String url = 'https://www.instagram.com/web/search/topsearch/?&query=%23';

  void _onButtonPressed() async {
    final response = await http.get('$url$_searchTerm');

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      insta = Insta.fromJson(jsonResponse);
      var items = insta.hashtags.length;

      setState(() {});

      print("Number hashtags: $items.");
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  }

  searchLocation() async {
    var a = googleUrl.replaceFirst("%url", _location);

    final response = await http.get(a);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      predictions = Predictions.fromJson(jsonResponse);

      var items = predictions.predictions.length;

      setState(() {});

      print("Number hashtags: $items.");
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  }

  Widget buildLocationList() {
    return Container(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: predictions.predictions.length,
          itemBuilder: (context, index) {
            var item = predictions.predictions[index];
            return ListTile(
              title: Text(item.description.toString()),
            );
          }),
    );
  }

  Map _selected = Map();

  Widget _buildList() {
    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: insta.hashtags.length - 1,
          itemBuilder: (context, index) {
            var item = insta.hashtags[index];
            var name = item.hashtag.name;
            var posts = item.hashtag.mediaCount;
            if (!_selected.containsKey(name)) _selected[name] = false;
            return ChoiceChip(
              label: Text(
                "$name - $posts posts",
                style: TextStyle(color: Colors.white),
              ),
              selectedColor: Colors.amber,
              disabledColor: Colors.blue,
              backgroundColor: Colors.blueAccent,

              selected: _selected[name],
              onSelected: (bool selected) {
                setState(() {
                  _selected[item.hashtag.name] = selected;
                });
              },
              // subtitle: Text(item.hashtag.mediaCount.toString())),
            );
          }),
    );
  }
}
