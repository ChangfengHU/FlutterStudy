import 'package:flutter/material.dart';

class LogoApp1 extends StatefulWidget {
  @override
  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<LogoApp1> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;
  @override
  void initState() {
    // TODO: implement initState1222
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 300).animate(animationController);
    animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '动画效果',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("动画效果"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: AnimatedLogo(animation:animation),
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  
  AnimatedLogo({Key key, Animation<double> animation})
      :super(key :key,listenable:animation);
  
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation=listenable;
    
    // TODO: implement build
    return Column(
      children: <Widget>[
        Text(
          "value:" + animation.value.toString(),
          textDirection: TextDirection.ltr,
        ),
        Text(
          "state:" + animation.status.index.toString(),
          textDirection: TextDirection.ltr,
        ),
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical:10),
            height:animation.value,
            width:animation.value,
            child: FlutterLogo(),
          ),
        ),
       
      ],
    );
  }
}