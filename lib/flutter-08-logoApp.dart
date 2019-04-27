import 'package:flutter/material.dart';
class LogoApp extends StatefulWidget {
  @override
  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;
  AnimationStatus animationStatus;
  double animationValue;
  @override
  void initState() {
    // TODO: implement initState122
    super.initState();
    animationController =AnimationController(vsync: this,duration: Duration(seconds: 2));
    animation=Tween<double>(begin: 0,end: 300).animate(animationController)
    ..addListener((){})
    ..addStatusListener(( AnimationStatus animationStatus){
    
    });
    
    
  }
  
  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}
