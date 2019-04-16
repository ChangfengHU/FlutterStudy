import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
    return   MaterialApp(
      title: '拍照app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("拍照app"),
          leading:GestureDetector(
            onTap:(){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ) ,
        ),
        body: Center(
          child: buildContainer(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _pinkImage,
          tooltip: '选择照片',
          child: Icon(Icons.add_a_photo),
        ),
      ),
    );;
  }
  Future getImage(bool isTakePhote) async {
    Navigator.pop(context);
    var image = await ImagePicker.pickImage(source: isTakePhote?ImageSource.camera:ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  Widget buildContainer() {
    return Column(
      children: <Widget>[
        _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ],
    );
  }

  void _pinkImage() {
    showModalBottomSheet(context: context, builder: (context)=>Container(
      height: 160,
      child: Column(
        children: <Widget>[
          _Item("拍照",true),
          _Item("从相机中选择",false),
        ],
      ),
    ));
  }

  _Item(String title, bool isTakePhote) {
    return GestureDetector(
          child: ListTile(
            leading: Icon(isTakePhote ?Icons.camera_alt:Icons.photo_library),
            title:Text(title),
            onTap: () =>getImage(isTakePhote),
          ),
    );
  }
}
