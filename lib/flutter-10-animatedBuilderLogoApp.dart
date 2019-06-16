import 'package:flutter/material.dart';

class LogoApp2 extends StatefulWidget {
  @override
  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<LogoApp2> with SingleTickerProviderStateMixin {
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
      title: '动画效果1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("动画效果1"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: GrowTransition(animation:animation,child:LogoWidget() ,) ,
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: FlutterLogo(),
    );
  }
}

class GrowTransition extends StatelessWidget {
  const GrowTransition({Key key, this.animation, this.child});
  final Widget child;
  final Animation<double> animation;
  
  @override
  Widget build(BuildContext context) {
    return buildAnimatedBuilder();
  }

  AnimatedBuilder buildAnimatedBuilder() {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
      return Container (
        height: animation.value,
        width: animation.value,
        child:child ,
      );
  },
      child: child,
  );
  }
}

