import 'package:english_words/english_words.dart';
import 'package:fluter/HomePage.dart';
import 'package:fluter/flutter-04-gesturePage.dart';
import 'package:fluter/flutter-05-resource.dart';
import 'package:fluter/flutter-06-otherResource.dart';
import 'package:fluter/flutter-07-photo_app_age.dart';
import 'package:flutter/material.dart';
import 'package:fluter/flutter-01-statelessWidgets.dart';
import 'package:fluter/flutter-02-statefulWidgets.dart';
import 'package:fluter/flutter-03-layoutPage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"demo",
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: RouteNavigator() ,
      routes: <String, WidgetBuilder>{
          'less':(BuildContext context) => MyWidgeTest(),
          'ful':(BuildContext context) => MyStatefulWidgetApp(),
          'layout':(BuildContext context) => MyLayoutWidgetApp(),
    },
    );
  }

}
class RouteNavigator extends StatefulWidget {
  @override
  _RouteNavigatorState createState() => new _RouteNavigatorState();
}

class _RouteNavigatorState extends State<RouteNavigator> {
  final _saved = new Set<WordPair>();
  
  bool byName =true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("路由"),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
          ]
      ),
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
          final tiles = _saved.map((pair) {
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
            body: new ListView(
                children: divided),
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
      children: <Widget>[SwitchListTile(
          title: Text("${byName?"":"不"} 通过路由名字跳转"),
          value: byName,
          onChanged: (value){
        print(value);
        setState(() {
          byName=!byName;
        });
        return value;
      }),
        _item("Flutter之布局的相关组件", MyStatefulWidget(title: '布局组建'),"layout"),
        _item("Flutter之处理手势",GesturePage(),"gesture"),
        _item("Flutter之加载本地资源",ImageWidget(),"image"),
        _item("Flutter之第三方资源",OtherResourseWidget(),"otherResoure"),
        _item("Flutter之拍照",PhotoApp(),"map"),
      ],
    ),
  );
  }

    _item(String title, page, String  rountName) {
      return Container(
        width: 300,
        child: RaisedButton(
          onPressed: (){
          if(byName){
            Navigator.of(context).push( MaterialPageRoute(builder: (context)=>page));
//            Navigator.pushNamed(context, rountName);
          }
          },
            child: Text(title)),
      );
  }
}

