import 'package:flutter/material.dart';

import 'flutter-13-hero2.dart';



void main() {
  runApp(RadialExpansionDemo1());
}



class FirstPage extends StatelessWidget {
  
  final url="https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg";
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("页面切换动画图一"),
      ),
      body: buildCenter(context)
    );
  }

  Center buildCenter(BuildContext context) {
    return Center(
      child: Photohero(
           photo:url ,
           width: 100,
           ontTap: (){
             Navigator.of(context).push(
                 MaterialPageRoute(builder:(context)=> SecondPage(url:url)
                 )
             );
           }
      ),
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
      body: Photohero(
          photo:url ,
          width: 400,
          ontTap: (){
            Navigator.of(context).pop();
          }
      )
    );
  }
}

class Photohero extends StatelessWidget {
  final String photo;
  final VoidCallback ontTap;
  final double width;

  const Photohero({Key key, this.photo, this.ontTap, this.width}) : super(key: key);
  

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
