import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math' as math;
void main() {
  runApp(new RadialExpansionDemo1());
}

class RadialExpansionDemo1 extends StatelessWidget {
  static const double kMinRadius = 32.0;
  static const double kMaxRadius = 128.0;
  static const opacityCurve = const Interval(0.0, 1, curve: Curves.fastOutSlowIn);
  
  static RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }



  Widget _buildHero(BuildContext context, String imageName, String description) {
    return Container(
      width: kMinRadius * 2.0, //64
      height: kMinRadius * 2.0,
      child: Hero(
        createRectTween: _createRectTween,
        tag: imageName,
        child: RadialExpansion(
          maxRadius: kMaxRadius, //128
          child: Photo(
            photo: imageName,
            onTap: () {
              Navigator.of(context).push(
                  PageRouteBuilder<void>(
                  pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                return AnimatedBuilder(
                    animation: animation,
                    builder: (BuildContext context, Widget child) {
                      return Opacity(
                        opacity: opacityCurve.transform(animation.value),
                        child: _buildPage(context, imageName, description),
                      );
                    }
                );
              },
              ),
              );
            },
          ),
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
                width: kMaxRadius * 2.0,//256
                height: kMaxRadius * 2.0,
                child: Hero(
                  createRectTween: _createRectTween,
                  tag: imageName,
                  child: RadialExpansion(
                    maxRadius: kMaxRadius,
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
  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0; // 1.0 is normal animation speed.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Transition Demo'),
      ),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        alignment: FractionalOffset.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHero(context, 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558548883006&di=0a42086e9ccbd08c6992d916d7d013a5&imgtype=0&src=http%3A%2F%2Fs1.sinaimg.cn%2Fmiddle%2F6242a0a1g91fe5776ded0%26690', 'Chair'),
            _buildHero(context, 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558548817411&di=4a43df1bd9aaeb5a5a22b344b7d491fb&imgtype=0&src=http%3A%2F%2Fimg.hexun.com%2F2008-03-17%2F104521893.jpg', 'Binoculars'),
            _buildHero(context, 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558548847332&di=7bf8fc29820bf9f53283263205c98188&imgtype=0&src=http%3A%2F%2Fs16.sinaimg.cn%2Fbmiddle%2F51fe0a1444c3fd3cbd74f', 'Beach ball'),
          ],
        ),
      ),
    );
  }
}

class RadialExpansion extends StatelessWidget {
  RadialExpansion({Key key, this.maxRadius, this.child})
      :clipRectSize=2.0*(maxRadius/math.sqrt2), super(key: key);
  final double maxRadius;
  final double clipRectSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          height:maxRadius ,
          width: maxRadius,
          child: child,
        ),
      ),
    );
  }
}


class Photo extends StatelessWidget {
  final String photo;
  final VoidCallback onTap;
  final double width;

   Photo({Key key, this.photo, this.onTap, this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Material(
      color: Colors.pink,
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(builder: (context,size){
        return Image.network(
            photo,
            fit: BoxFit.contain,
        );
        })
      ),
    );
  }
}