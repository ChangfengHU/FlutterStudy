import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
class MyLayoutWidgetApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '测试',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        brightness: Brightness.light,
        primaryColorBrightness: Brightness.dark,
      ),
      home: MyStatefulWidget(title: '布局组建'),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> with TickerProviderStateMixin {
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
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people,color: Colors.green,),
          activeIcon: Icon(Icons.account_box,color: Colors.pink,),
          title: Text("好友"),
        ),
      ]),
      body: getBodyPage(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Fade',
        child: Icon(Icons.brush),
        onPressed: () {
          _toggle();
        },
      ),
    );
  }

  Widget getBodyPage() {
    if ( _currentIndex==0){
      return RefreshIndicator(child:
      ListView(
        children: <Widget>[
          ContainerComponment(),
        ],
      ),onRefresh: handleRefreshIndicator
      );
    }
    if ( _currentIndex==1) {
      return ListView(children: <Widget>[
        Row(children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.center,
            child:ClipOval(
              child:Image.network(
                "http://www.devio.org/img/avatar.png", width: 100,
                height: 100,) ,
            ) ,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.network(
                "http://www.devio.org/img/avatar.png", width: 100,
                height: 100,),
            ),
          ),
        ],),
        TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              hintText: "请输入...",
              hintStyle: TextStyle(fontSize: 20)
          ),
        ),
        Container(
          height: 100,
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white10),
          child: PhysicalModel(
            color: Colors.yellowAccent,
            borderRadius: BorderRadius.all(Radius.circular(20)),//圆角
            clipBehavior: Clip.antiAlias,//抗齿距
            child: PageView(
              children: <Widget>[
                _item("PageView1", Colors.blue),
                _item("PageView2", Colors.pink),
                _item("PageView3", Colors.deepPurple),
                _item("PageView", Colors.indigo),
                _item("PageView5", Colors.teal),
              ],
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: FractionallySizedBox(
                widthFactor: 0.25,
                child: Container(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text("盛满宽1度"),
                 ),
              ),
            ),
            Wrap(
              children: <Widget>[
                _chip ("学习"),
                _chip ("安卓"),
                _chip ("天天"),
                _chip ("为难"),
                _chip ("加油"),
                _chip ("奋斗"),
              ],
            ),
            Stack(
              children: <Widget>[
                Image.network("http://www.devio.org/img/avatar.png", width: 100, height: 100,),
                Positioned(
                  bottom: 0,
                    left: 0,
                    child: Image.network("http://www.devio.org/img/avatar.png", width: 60, height: 60,)
                
                ),
                
              ],
            ),
          ],
        ),
      ],);
    }
    if ( _currentIndex==2){
      return Column(children: <Widget>[
      ClipOval(
        child:SizedBox(
          width: 50,
          height: 50,
          child: Image.network(
            "http://www.devio.org/img/avatar.png"),
        )),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Opacity(opacity:0.9,child: Image.network("http://www.devio.org/img/avatar.png"))),
        ),
         Expanded(
           child: Container(
             decoration: BoxDecoration(color: Colors.yellowAccent),
             child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Opacity(opacity:0.8,child: Image.network("http://www.devio.org/img/avatar.png",width: 50,height: 50,))),
           ),
         )
      ] ,
      );
    }
  }

  Container  _chip (text) {
    return Container(
                decoration: BoxDecoration(color: Colors.white10),
                  width: 120,
                  child: Chip(avatar:Icon(Icons.people),label: Text(text),
                      labelStyle:TextStyle(color: Colors.pink,fontSize: 20,fontWeight:
                      FontWeight.w100)));
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
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(color: blue),
      child: Text(title,style: TextStyle(color:Colors.black ,fontSize: 30),),
    );
  }

}


