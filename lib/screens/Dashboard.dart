import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tag_me/components/DefaultButton.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  File _image;
  List<Label> _labels;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.purple[400], Colors.yellow[400]])),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  height: 300.0,
                  child: _image == null
                      ? Text('No image selected.')
                      : Image.file(_image),
                ),
                DefaultButton(
                  title: "Pick Image from gallery",
                  onPress: _pickImagePressedCamera,
                ),
                DefaultButton(
                  title: "Pick Image from camera",
                  onPress: _pickImagePressed,
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Labels:",
                  style: TextStyle(fontSize: 40),
                ),
                Container(
                    height: 400,
                    width: double.infinity,
                    child: _labels == null
                        ? Text("No labels yet")
                        : _buildSuggestions())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      itemCount: _labels.length,
      padding: const EdgeInsets.all(10.0),
      itemBuilder: (context, i) {
        final item = _labels[i];

        return ListTile(
          title: Text(item.label),
          subtitle: Text("confidence: " + item.confidence.toString()),
        );
      },
    );
  }

  void _pickImagePressed() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    _image = image;

    _labelImage();
  }

  void _pickImagePressedCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    _image = image;

    _labelImage();
  }

  void _labelImage() async {
    var firebaseVisionImage = FirebaseVisionImage.fromFile(_image);
    final LabelDetector labelDetector = FirebaseVision.instance.labelDetector();
//
//    final FaceDetector faceDetector = FirebaseVision.instance.faceDetector();
//
//    final List<Face> faces = await faceDetector.processImage(firebaseVisionImage);
    _labels = await labelDetector.detectInImage(firebaseVisionImage);

    setState(() {});
  }
}
