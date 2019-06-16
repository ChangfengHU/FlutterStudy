import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HeroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0;
    return MaterialApp(
      title: 'hero动画',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("hero动画"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Center(
          child: Photohero("http://k.zol-img.com.cn/sjbbs/7692/a7691515_s.jpg",
              () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MaterialApp(
                      title: 'hero动画',
                      theme: ThemeData(
                        primarySwatch: Colors.grey,
                      ),
                      home: Scaffold(
                        appBar: AppBar(
                          title: Text("hero动画1"),
                        ),
                        body: Container(
                          padding: EdgeInsets.all(16),
                          alignment: Alignment.topLeft,
                          child: Photohero(
                              "http://k.zol-img.com.cn/sjbbs/7692/a7691515_s.jpg",
                              () {
                            Navigator.of(context).pop();
                          }, 100),
                        ),
                      ),
                    )));
          }, 300),
        ),
      ),
    );
  }
}

class Photohero extends StatelessWidget {
  final String photo;
  final VoidCallback ontTap;
  final double width;

  Photohero(this.photo, this.ontTap, this.width);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
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
