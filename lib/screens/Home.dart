import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tag_me/bloc/BlocProvider.dart';
import 'package:tag_me/bloc/HashtagBloc.dart';
import 'package:tag_me/components/HashtagChip.dart';
import 'package:tag_me/models/HashtagItem.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File _image;
  List<Label> _labels;
  HashtagBloc _hashtagBloc;


  @override
  void initState() {
    _iniatiliseTFModel();
  }

  @override
  Widget build(BuildContext context) {
    _hashtagBloc = BlocProvider.of(context);

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
                  child: StreamBuilder(
                      stream: _hashtagBloc.outPictureHashtag,
                      builder:
                          (context, AsyncSnapshot<List<HashtagItem>> snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                              child:
                                  _buildChips(snapshot.data, 1, _hashtagBloc));
                        } else {
                          return Container(
                              height: 100.0,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        }
                      }),
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

    _label();

//    setState(() {});
//
//    _labelImage();
  }

  Future _labelImage() async {
    var firebaseVisionImage = FirebaseVisionImage.fromFile(_image);
    final LabelDetector labelDetector = FirebaseVision.instance.labelDetector();
//
//    final FaceDetector faceDetector = FirebaseVision.instance.faceDetector();
//
//    final List<Face> faces = await faceDetector.processImage(firebaseVisionImage);
    _labels =
        await labelDetector.detectInImage(firebaseVisionImage).then((labels) {
      _hashtagBloc.getHashtagsforPictureLabel(labels[0].label);
      setState(() {});
    });
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

  Future _iniatiliseTFModel() async {
    String res = await Tflite.loadModel(
        model: "assets/mobilenet_v1_1.0_224.tflite",
        labels: "assets/mobilenet_v1_1.0_224.txt",
        numThreads: 1 // defaults to 1
    );
  }

  Future _label() async {
    var recognitions = await Tflite.detectObjectOnImage(
        path: _image.path,
    );
    print(recognitions);
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

  Widget _buildChips(
      List<HashtagItem> hashtags, int i, HashtagBloc hashtagBloc) {
    List<Widget> _hashtagChips = List();

    hashtags.forEach((hashtag) {
      _hashtagChips.add(HashtagChip(hashtag, hashtagBloc));
    });

    return Wrap(
        spacing: 4.0, alignment: WrapAlignment.center, children: _hashtagChips);
  }
}
