import 'package:flutter/material.dart';

void main() {
  runApp(TabBarLess());
}

class TabBarLess extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TabBar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        primaryColorBrightness: Brightness.dark,
      ),
      home: TabBarTest(title: 'tabBar'),
    );
  }
}

class TabBarTest extends StatefulWidget {
  TabBarTest({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _TabBarState createState() => _TabBarState();
}

class _TabBarState extends State<TabBarTest> {
  var textStyle =TextStyle(color: Colors.pink,fontSize: 50,fontWeight: FontWeight.w400);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length:ItemViems.length ,
        child: Scaffold(
          appBar: AppBar(
            title:Text("TabBar选项卡示例") ,
            bottom: TabBar(
                isScrollable: true,
                tabs:tabs
            ),
          ),
          body: TabBarView(children: tabsWidgets),
          
        )
    );
  }
 
}

class ItemViem {
  final String title;
  final IconData icon;
  ItemViem({this.title, this.icon});
}
 List<ItemViem>  ItemViems =  <ItemViem>[
   ItemViem(title:"自驾", icon:Icons.directions_car),
   ItemViem(title:"自行车", icon:Icons.directions_bike),
   ItemViem(title:"轮船", icon:Icons.directions_boat),
   ItemViem(title:"公交车", icon:Icons.directions_bus),
   ItemViem(title:"火车", icon:Icons.directions_railway),
   ItemViem(title:"步行", icon:Icons.directions_walk),
];

final List<Tab> tabs=ItemViems.map((ItemViem itemViem)=> Tab(text: itemViem.title,
icon:Icon(itemViem.icon) ,
)).toList();

final List<Widget> tabsWidgets=ItemViems.map((ItemViem itemViem)=> Padding(
  child:SelectView(itemViem:itemViem) ,
  padding: EdgeInsets.all(5),
)).toList();

class SelectView extends StatelessWidget {
  final ItemViem itemViem;
  const SelectView({Key key, this.itemViem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var textStyle =Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,//垂直方向最小化处理
          crossAxisAlignment: CrossAxisAlignment.center,//水平方向居中处理
          children: <Widget>[
            Icon(itemViem.icon,size: 128,color: textStyle.color,),
            Text(itemViem.title,style: textStyle,)
          ],
        ),
      ),
    );
  }
}
