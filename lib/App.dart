import 'package:flutter/material.dart';

void main() {
  runApp(DemoApp());
}

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => new _DemoAppState();
}
enum ConferenceItem { AddMember, LockConference, ModifyLayout, TurnoffAll }
class _DemoAppState extends State<DemoApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "demo",
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(
            title: Text("路由"),
            leading: Icon(Icons.close),
            actions: <Widget>[
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
                        const PopupMenuItem<ConferenceItem>(//菜单项
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
      ),
    );
  }

  buildContainer() {
    return Text("你好");
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
