import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class OtherResourseWidget extends StatefulWidget {
  @override
  _OtherResourseWidgetState createState() => new _OtherResourseWidgetState();
}

class _OtherResourseWidgetState extends State<OtherResourseWidget> {
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      title: '加载外部资源',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("加载外部资源"),
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
      ),
    );;
  }

  Widget buildContainer() {
    return Column(
      children: <Widget>[
        RaisedButton(
          onPressed: _launchURL,
          child: Text('打开浏览器'),
        ),
        RaisedButton(
          onPressed: _openMap,
          child: Text('打开地图'),
        ),
      ],
    );
  }
  //加载外部资源 如地图,需要引入url_launch包
  _launchURL() async {
    const url = 'https://www.baidu.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      
      throw 'Could not launch $url';
    }
  }

  void _openMap() async{
    const url ="geo:52.32,4.917";//app开发者提供的scmahe
    if(await canLaunch(url)){
      await launch(url);
    }else{
      const url1 ="http:maps.apple.com/?ll:52.32,4.917";
      if(await canLaunch(url1)){
        await launch(url1);
      }else{
        throw "Could not launch$url";
      }
    }
  }
}
