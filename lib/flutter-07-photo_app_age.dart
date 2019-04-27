import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';
/**
 * https://pub.dartlang.org/packages/
 * 引入image_picker 包
 */
class PhotoApp extends StatefulWidget {
  @override
  _PhotoAppState createState() => new _PhotoAppState();
}

class _PhotoAppState extends State<PhotoApp> {
  File _image;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '拍照app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("拍照app"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body:Container(
          child: Column(
            children: <Widget>[
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: _getImages(),
              ),

              Container(
                child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: "http://www.devio.org/img/avatar.png"),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _pinkImage,
          tooltip: '选择照片',
          child: Icon(Icons.add_a_photo),
        ),
      ),
    );
    ;
  }

  List<File> _images = [];
  Future getImage(bool isTakePhote) async {
    Navigator.pop(context);
    var image = await ImagePicker.pickImage(
        source: isTakePhote ? ImageSource.camera : ImageSource.gallery);
    setState(() {
      if (image != null) {
        _images.add(image);
      }
    });
  }

  void _pinkImage() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: 120,
              child: Column(
                children: <Widget>[
                  _Item("拍照", true),
                  _Item("从相机中选择", false),
                ],
              ),
            ));
  }

  _Item(String title, bool isTakePhote) {
    return GestureDetector(
      child: ListTile(
        leading: Icon(isTakePhote ? Icons.camera_alt : Icons.photo_library),
        title: Text(title),
        onTap: () => getImage(isTakePhote),
      ),
    );
  }

  _getImages() {
    return _images.map((file) {
      return Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.file(
              file,
              width: 120,
              height: 90,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _images.remove(file);
                });
              },
              child: ClipOval(
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(color: Colors.black),
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      );
    }).toList();
  }
}
