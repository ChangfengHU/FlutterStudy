import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
class MyStatelessWidgetApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'demo 测试',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        brightness: Brightness.light,
        primaryColorBrightness: Brightness.dark,
      ),
      home: MyWidgeTest(title: 'Fade Demo1'),
    );
  }
}

class MyWidgeTest extends StatefulWidget {
  MyWidgeTest({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyFadeTest createState() => _MyFadeTest();
}

class _MyFadeTest extends State<MyWidgeTest> with TickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curve;
  Color color2 = ColorUtil.color('#a11F5733');
  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }
  var textStyle =TextStyle(color: Colors.pink,fontSize: 50,fontWeight: FontWeight.w400);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading:GestureDetector(
          onTap:(){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ) ,
      ),
      body: Container(
        decoration: BoxDecoration(color:_getColor()),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text("文本",style: textStyle,),
            Icon(Icons.android,color: Colors.green,size: 40,),
            CloseButton(),
            BackButton(),
            Chip(avatar:Icon(Icons.people),label: Text("这是文本"),labelStyle:textStyle),
            Divider(
              color: Colors.yellow,
              height: 16,
              indent: 20,
            ),
            Card(
                color:Colors.teal,
                elevation: 10,
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: Container(
                  padding: EdgeInsets.all(1),
                  child: Text("在哪呢",style: textStyle,),
                )
            ),
            AlertDialog(
              title:Text("你好"),
              content: Text("真是的"),

            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Fade',
        child: Icon(Icons.brush),
        onPressed: () {
          _toggle();
        },
      ),
    );
  }

  bool flag=true;
  void _toggle() {
    setState(() {
      print(1111);
      flag=!flag;
    });
  }
  _getColor() {
    if(flag){
      return ColorUtil.color('#a11F5733');
    }else {
      return Colors.pink;
    }
  }

}