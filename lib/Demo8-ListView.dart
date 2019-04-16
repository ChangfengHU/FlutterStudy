import 'package:flutter/material.dart';

void main() {
  runApp(FadeAppTest());
}

class FadeAppTest extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fade Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        primaryColorBrightness: Brightness.dark,
      ),
      home: MyFadeTest(title: 'Fade Demo1'),
    );
  }
}

class MyFadeTest extends StatefulWidget {
  MyFadeTest({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyFadeTest createState() => _MyFadeTest();
}

class _MyFadeTest extends State<MyFadeTest> with TickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }
  var textStyle =TextStyle(color: Colors.pink,fontSize: 50,fontWeight: FontWeight.w400);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: ListView(children:listData(),),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Fade',
            child: Icon(Icons.brush),
            onPressed: () {
              controller.forward();
            },
          ),
        )
    );
  }


  listData() {
    var list= <Widget>[];
    for (var i = 0; i < 100; ++i) {
      list.add( Text ("列表数据$i",style:textStyle ),);

    }
    return list;
  }
}