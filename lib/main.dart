import 'package:english_words/english_words.dart';
import 'package:fluter/flutter-04-gesturePage.dart';
import 'package:fluter/flutter-05-resource.dart';
import 'package:fluter/flutter-06-otherResource.dart';
import 'package:fluter/flutter-07-photo_app_age.dart';
import 'package:flutter/material.dart';
import 'package:fluter/flutter-01-statelessWidgets.dart';
import 'package:fluter/flutter-02-statefulWidgets.dart';
import 'package:fluter/flutter-03-layoutPage.dart';
import 'flutter-08-logoApp.dart';
import 'flutter-09-animatedWidgetLogoApp.dart';
import 'flutter-10-animatedBuilderLogoApp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "demo",
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: RouteNavigator(),
      routes: <String, WidgetBuilder>{
        'less': (BuildContext context) => MyWidgeTest(),
        'ful': (BuildContext context) => MyStatefulWidgetApp(),
        'layout': (BuildContext context) => MyLayoutWidgetApp(),
      },
    );
  }
}

class RouteNavigator extends StatefulWidget {
  @override
  _RouteNavigatorState createState() => new _RouteNavigatorState();
}

enum ConferenceItem { AddMember, LockConference, ModifyLayout, TurnoffAll }

class _RouteNavigatorState extends State<RouteNavigator> {
  final _saved = new Set<WordPair>();

  bool byName = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("路由"),
          leading: Icon(Icons.close),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
            new IconButton(icon: new Icon(Icons.list), onPressed: () {}),
            Padding(
              //左右内边距
              padding: const EdgeInsets.only(left: 30.0, right: 20.0),
              child: GestureDetector(
                onTap: () {
                  //弹出菜单
                  print("打开");
                  showMenu(
                    context: context,
                    //定位在界面的右上角
                    position: RelativeRect.fromLTRB(500.0, 80.0, 10.0, 0.0),
                    //展示所有菜单项
                    items: <PopupMenuEntry<ConferenceItem>>[
                      const PopupMenuItem<ConferenceItem>(
                        //菜单项
                        value: ConferenceItem.AddMember,
                        child: Text('添加成员'),
                      ),
                      const PopupMenuItem<ConferenceItem>(
                        value: ConferenceItem.LockConference,
                        child: Text('锁定会议'),
                      ),
                      const PopupMenuItem<ConferenceItem>(
                        value: ConferenceItem.ModifyLayout,
                        child: Text('修改布局'),
                      ),
                      const PopupMenuItem<ConferenceItem>(
                        value: ConferenceItem.TurnoffAll,
                        child: Text('挂断所有'),
                      ),
                    ],
                  );
                },
                //菜单按钮
                child: Icon(Icons.add),
              ),
            ),
          ]),
      body: buildContainer(),
    );
  }

  void _pushSaved() {
    var take = generateWordPairs().take(10);
    for (var o in take) {
      _saved.add(o);
    }
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: TextStyle(fontSize: 20),
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }

  Container buildContainer() {
    return new Container(
      decoration: BoxDecoration(color: Colors.white),
      margin: EdgeInsets.only(top: 60),
      width: 600,
      child: ListView(
        children: <Widget>[
          SwitchListTile(
              title: Text("${byName ? "" : "不"} 通过路由名字跳转"),
              value: byName,
              onChanged: (value) {
                print(value);
                setState(() {
                  byName = !byName;
                });
                return value;
              }),
          _item("Flutter之布局的相关组件", MyStatefulWidget(title: '布局组建'), "layout"),
          _item("Flutter之处理手势", GesturePage(), "GesturePage"),
          _item("Flutter之加载本地资源", ImageWidget(), "ImageWidget"),
          _item("Flutter之第三方资源", OtherResourseWidget(), "OtherResourseWidget"),
          _item("Flutter之拍照", PhotoApp(), "PhotoApp"),
          _item("Flutter之动画效果", LogoApp(), "LogoApp"),
          _item("Flutter之动画效果1", LogoApp1(), "LogoApp"),
          _item("Flutter之动画效果2", LogoApp2(), "LogoApp"),
//        _item("Flutter之hero动画",HeroApp(),"LogoApp"),
//        _item("Flutter之hero动画1",RadialExpansionDemo(),"LogoApp"),
//        _item("Flutter之hero动画2",RadialExpansionDemo1(),"LogoApp"),
        ],
      ),
    );
  }

  _item(String title, page, String rountName) {
    return Container(
      width: 300,
      child: RaisedButton(
          onPressed: () {
            if (byName) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => page));
//            Navigator.pushNamed(context, rountName);
            }
          },
          child: Text(title)),
    );
  }

  //渲染某个菜单项 传入菜单标题 图片路径或图标
  _popupMenuItem(String title, {String imagePath, IconData icon}) {
    return PopupMenuItem(
      child: Row(
        children: <Widget>[
          //判断是使用图片路径还是图标
          imagePath != null
              ? Image.asset(
                  imagePath,
                  width: 32.0,
                  height: 32.0,
                )
              : SizedBox(
                  width: 32.0,
                  height: 32.0,
                  child: Icon(
                    icon,
                    color: Colors.black,
                  ),
                ),
          //显示菜单项文本内容
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
