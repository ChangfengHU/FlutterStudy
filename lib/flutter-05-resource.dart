import 'package:flutter/material.dart';
class ImageWidget extends StatefulWidget {
  @override
  _ImageWidgetState createState() => new _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Image(image:AssetImage("images/image.jpg") ),
    );
  }
}
