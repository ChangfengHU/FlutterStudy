import 'package:flutter/material.dart';

class MyyuanfangApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '更换组建',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState () => _SampleAppPageState();

}

class _SampleAppPageState extends State<SampleAppPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
        leading:GestureDetector(
          onTap:(){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ) ,
      ),
      body: Center(
        child: _getToggleChild(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        tooltip: 'Update Text',
        child: Icon(Icons.update),
      ),
    );
  }
  bool flag=true;
  void _toggle() {
    setState(() {
      flag=!flag;
    });
  }

  _getToggleChild() {
    if(flag){
      return Text ("widget1");
    }else {
      return MaterialButton(onPressed: (){},child: Text("11221"));
    }
  }
}
//如何在布局中添加或删除组件？更新组建