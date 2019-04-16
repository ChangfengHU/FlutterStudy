import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class GesturePage extends StatefulWidget {
  @override
  _GesturePageState createState() => new _GesturePageState();
}

class _GesturePageState extends State<GesturePage> {
  bool itemFlag=true;

  String printMsg="";

  double moveX=0;
  double moveY=0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "11",
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: itemFlag?Brightness.dark:Brightness.light
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("处理手势"),
          leading: GestureDetector(
            onTap: ()=>Navigator.pop(context),
            child: Icon(Icons.arrow_back),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: '悬浮',
          child: Icon(Icons.brush),
          onPressed: () {
            _change();
          },
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(color: Colors.grey),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: moveX,
                    top: moveY,
                    child: GestureDetector(
                      onTap:()=> _printMsg("点击"),
                      onDoubleTap:()=> _printMsg("双击"),
                      onLongPress:()=> _printMsg("长按"),
                      onPanUpdate: (e){
                        print("拖动");
                        setState(() {
                          moveX+=e.delta.dx;
                          moveY+=e.delta.dy;
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.orange),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          RaisedButton(
            onPressed: _launchURL,
            child: Text('Show Flutter homepage'),
          ),
            Container(
                child: Wrap(children:listData(),)),
          ],
        ),
      
      ),
    );
  }

  _launchURL() async {
    const url = 'https://flutter.io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  var list= <String>[];
  _printMsg(String s) {
    setState(() {
      list.add(s);
    });
  }

  void _change() {
    list=<String>[];
    setState(() {
      itemFlag=!itemFlag;
    });
  }

  listData() {
    var listWidget= <Container>[];
    for (var i = 0; i < list.length; ++i) {
      listWidget.add(new Container(
          child: Chip(avatar: Icon(Icons.people), label: Text(list[i]),
              labelStyle: TextStyle(
                  color: Colors.pink, fontSize: 12, fontWeight:
              FontWeight.w100)))
      );
    }
  return listWidget;
  }
}
