import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'flutter-12-hero1.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = "淡入淡出动画示例";
    return new MaterialApp(
      title: appTitle,
      home: new MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  CurvedAnimation curve;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState1222
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 300).animate(animationController);
    curve = CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animationController.forward();
  }
  static const double kMinRadius = 32.0;
  static const double kMaxRadius = 128.0;
  static RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  //控制动画显示状态变量
//  final url="https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg";
  final url1 =
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558548883006&di=0a42086e9ccbd08c6992d916d7d013a5&imgtype=0&src=http%3A%2F%2Fs1.sinaimg.cn%2Fmiddle%2F6242a0a1g91fe5776ded0%26690";
  final url2 =
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558548817411&di=4a43df1bd9aaeb5a5a22b344b7d491fb&imgtype=0&src=http%3A%2F%2Fimg.hexun.com%2F2008-03-17%2F104521893.jpg";
  final url3 =
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558548847332&di=7bf8fc29820bf9f53283263205c98188&imgtype=0&src=http%3A%2F%2Fs16.sinaimg.cn%2Fbmiddle%2F51fe0a1444c3fd3cbd74f";
  @override
  Widget build(BuildContext context) {
    timeDilation = 3.0;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        alignment: FractionalOffset.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildCenter1(url1),
            buildCenter(url2),
            buildCenter(url3),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          animationController.reset();
          animationController.forward();
        },
        tooltip: "显示隐藏",
        child: new Icon(Icons.flip),
      ),
    );
  }

  ClipOval buildCenter1(String url) {
    //添加Opacity动画
    return ClipOval(
      child: Container(
        child: SizedBox(
          height: 64,
          width: 64,
          child: Hero(
              createRectTween: _createRectTween,
              tag: url,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    print("点击");
                    Navigator.of(context).push(PageRouteBuilder<void>(
                        pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) =>
                            AnimatedBuilder(
                                animation: animation,
                                builder: (BuildContext context, Widget child) {
                                  return _buildPage(context,url,"1233");
                                })));
                  },
                  child: Image.network(
                    url,
                    fit: BoxFit.contain,
                  ),
                ),
              )),
        ),
      ),
    );
  }
  
  
  static Widget _buildPage(BuildContext context, String imageName, String description) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: kMaxRadius * 2.0,
                height: kMaxRadius * 2.0,
                child: Hero(
                  createRectTween: _createRectTween,
                  tag: imageName,
                  child: SizedBox(
                    width: kMaxRadius,
                    child: Photo(
                      photo: imageName,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              Text(
                description,
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 3.0,
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
  
  ClipOval buildCenter(String url) {
    //添加Opacity动画
    return ClipOval(
      child: Container(
        child: SizedBox(
          height: 64,
          width: 64,
          child:
              FadeTransition(opacity: curve, child: buildAnimatedBuilder(url)),
        ),
      ),
    );
  }

  AnimatedBuilder buildAnimatedBuilder(String url) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        return Container(
          height: animation.value,
          width: animation.value,
          child: child,
        );
      },
      child: Photohero(
          photo: url,
          width: 128,
          ontTap: () {
            print('12111111');
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SecondPage(url: url)));
          }),
    );
  }
}

class Photohero extends StatelessWidget {
  final String photo;
  final VoidCallback ontTap;
  final double width;

  const Photohero({Key key, this.photo, this.ontTap, this.width})
      : super(key: key);

  static RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
          createRectTween: _createRectTween,
          tag: photo,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: ontTap,
              child: Image.network(
                photo,
                fit: BoxFit.contain,
              ),
            ),
          )),
    );
  }
}

class SecondPage extends StatelessWidget {
  final String url;

  const SecondPage({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("页面切换动画图二"),
        ),
        body: Center(
          child: Photohero(
              photo: url,
              width: 128,
              ontTap: () {
                Navigator.of(context).pop();
              }),
        ));
  }
}
