import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  
  var imgUrlList = [
    'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg',
    'https://ws1.sinaimg.cn/large/0065oQSqly1fw8wzdua6rj30sg0yc7gp.jpg',
    'https://ws1.sinaimg.cn/large/0065oQSqly1fw0vdlg6xcj30j60mzdk7.jpg',
    'https://ws1.sinaimg.cn/large/0065oQSqly1fuo54a6p0uj30sg0zdqnf.jpg'
  ];
  
  PageController controller = new PageController();
  var pageOffset = 0.0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      pageOffset = controller.offset / 200;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: PageView(
            controller: controller,
            children: imgUrlList
                .map((item) => buildPageItem(imgUrlList.indexOf(item), item))
                .toList(),
          ),
          width: 200,
          height: 200,
        ),
      ),
    );
  }
  

  Widget buildPageItem(int index, String imgUrl) {
    var currentLeftPageIndex = pageOffset.floor();
    var currentPageOffsetPercent = pageOffset - currentLeftPageIndex;
    return Transform.translate(
      offset: Offset((pageOffset - index) * 200, 0),
      child: Transform.scale(
        scale: currentLeftPageIndex == index
            ? 1 - currentPageOffsetPercent
            : currentPageOffsetPercent,
        child: Image.network(imgUrl),
      ),
    );
  }
}
