import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tag_me/components/CategoryDetailCard.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File _image;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          buildImageCard(context),
          SizedBox(height: 12.0),
          _image == null ? Container() : _buildHashtagHeader(context),
          SizedBox(height: 12.0),
          _image == null
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CategoryDetailCard(title: "travel"),
                ),
        ],
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  void _pickImagePressed() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    _image = image;

    setState(() {});

//    _labelImage();
  }

  Widget _buildHashtagHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            FontAwesomeIcons.hashtag,
            color: Theme.of(context).primaryColor,
            size: 48.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            "Hashtags",
            style: Theme.of(context)
                .textTheme
                .title
                .apply(color: Theme.of(context).primaryColor),
          ),
        )
      ],
    );
  }

  Widget buildImageCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: _pickImagePressed,
        child: Card(
          child: Container(
            height: 200.0,
            child: Center(
                child: _image != null
                    ? Image.file(_image)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.cameraRetro,
                            size: 48.0,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text("Add picture to generate hashtags"),
                        ],
                      )),
          ),
        ),
      ),
    );
  }
}
