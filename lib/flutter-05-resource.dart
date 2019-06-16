import 'package:flutter/material.dart';
//import 'package:cached_network_image/cached_network_image.dart';

class ImageWidget extends StatefulWidget {
  @override
  _ImageWidgetState createState() => new _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  var assetUrl = "images/image.jpg";
  var url = "http://www.devio.org/img/avatar.png";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
/*        new Container(
          child: Image(image: AssetImage("images/image.jpg")),
        ),*/
//        Image.asset(
//          "images/image.jpg",
//        ),
        Row(
          children: <Widget>[
            Image.asset(assetUrl,width: 150,),
            Text("本地图片",style: TextStyle(fontSize: 20))
          ],
        ),
        Row(
          children: <Widget>[
            Image.network(url),
            Text("网络图片",style: TextStyle(fontSize: 20))
          ],
        ),
        Row(
          children: <Widget>[
            FadeInImage.assetNetwork(placeholder: url, image: url),
            Text("渐变网络图片",style: TextStyle(fontSize: 20),)
          ],
        ),
//        new Image(image: new CachedNetworkImageProvider(url)),
//        Row(
//          children: <Widget>[
//            new CachedNetworkImage(
//              imageUrl: url,
//              placeholder: (context, url) => new CircularProgressIndicator(),
//              errorWidget: (context, url, error) => new Icon(Icons.error),
//            ),
//            Text("缓存图片",style: TextStyle(fontSize: 20))
//          ],
//        ),
      ],
    );
  }
}
