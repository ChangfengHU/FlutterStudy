import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
class MyStatefulWidgetApp extends StatelessWidget {
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
      home: MyStatefulWidget1(title: '有状态组件'),
    );
  }
}

class MyStatefulWidget1 extends StatefulWidget {
  MyStatefulWidget1({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget1> with TickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curve;
  getColor(color){
    Color color2 = ColorUtil.color('$color');
    return color2;
  }
  Color color2 = ColorUtil.color('#a11F5733');
  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }
  var textStyle =TextStyle(color: Colors.pink,fontSize: 50,fontWeight: FontWeight.w400);
  var _currentIndex=0;
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap:(index){
          print(index);
          setState(() {
            _currentIndex=index;
          });
        },
          items:[
        BottomNavigationBarItem(
          icon: Icon(Icons.home,color: Colors.green,),
          activeIcon: Icon(Icons.home,color: Colors.pink,),
          title: Text("首页"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people,color: Colors.green,),
          activeIcon: Icon(Icons.people,color: Colors.pink,),
          title: Text("联系人"),
        )
      ]),
      body: _currentIndex==0? RefreshIndicator(child:
         ListView(
           children: <Widget>[
             ContainerComponment(),
           ],
         ),onRefresh: handleRefreshIndicator
      ): Column(children: <Widget>[
        Image.network("http://s16.sinaimg.cn/mw690/001ve3i3zy6K4wK731J1f&690",width: 600,height: 200,),
        TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            hintText: "请输入...",
            hintStyle: TextStyle(fontSize: 30)
          ),
        ),
      Container(
        height: 100,
        margin: EdgeInsets.only(top: 10),
        decoration:BoxDecoration(color: Colors.white10),
        child:   PageView(
         children: <Widget>[
           _item("page1",Colors.blue),
           _item("page2",Colors.pink),
           _item("page3",Colors.deepPurple),
           _item("page4",Colors.indigo),
           _item("page5",Colors.teal),
         ],
        ),
      )
      ],),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Fade',
        child: Icon(Icons.brush),
        onPressed: () {
          _toggle();
        },
      ),
    );
  }

  Future<Null> handleRefreshIndicator() async{
    await Future.delayed(Duration(milliseconds: 1000));
    return null;
  }

  ContainerComponment(){
    return  Container(
      decoration: BoxDecoration(color:_getColor()),
      alignment: Alignment.center,
      child:  Column(
        children: <Widget>[
          Text("文本",style: textStyle,),
          Icon(Icons.android,color: Colors.green,size: 10,),
          CloseButton(),
          BackButton(),
          Chip(avatar:Icon(Icons.people),label: Text("这是文本"),labelStyle:textStyle),
          Divider(
            color: Colors.yellow,
            height: 3,
            indent: 3,
          ),
          Card(
              color:Colors.teal,
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
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
      ), );
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

  _item(String title, Color blue) {
    return Container(
      decoration: BoxDecoration(color: blue),
      child: Text(title,style: TextStyle(color:Colors.black ,fontSize: 30),),
    );
  }

}


