import 'package:flutter/material.dart';

class LogoApp extends StatefulWidget {
  @override
  _LogoAppState createState() => new _LogoAppState();
}

class AnimatedLogo extends AnimatedWidget {

  AnimatedLogo({Key key, Animation<double> animation})
      :super(key :key,listenable:animation);
  
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation=listenable;
    
    // TODO: implement build
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical:10),
        height:animation.value,
        width:animation.value,
        child: FlutterLogo(),
      ),
    );
  }

  
}
class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;
  AnimationStatus animationStatus;
  double animationValue;
  CurvedAnimation curve;
  @override
  void initState() {
    // TODO: implement initState1222
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 300).animate(animationController)
      ..addListener(() {
        setState(() {
          animationValue = animation.value;
        });
      })
      ..addStatusListener((AnimationStatus status) {
        setState(() {
          animationStatus = status;
        });
      });
    curve = CurvedAnimation(parent: animationController, curve: Curves.easeIn);
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
        body: buildContainer(),
      ),
    );
  }

  Container buildContainer() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              animationController.reset();
              animationController.forward();
            },
            child: Text(
              "Start",
              textDirection: TextDirection.ltr,
            ),
          ),
          Text(
            "state:" + animationStatus.toString(),
            textDirection: TextDirection.ltr,
          ),
          Text(
            "value:" + animationValue.toString(),
            textDirection: TextDirection.ltr,
          ),
          Container(
            height: animationValue,
            width: animationValue,
            child: FlutterLogo(),
          ),
          FadeTransition(
              opacity: curve,
              child: FlutterLogo(
                size: 100.0,
              ))
        ],
      ),
    );
  }
}
