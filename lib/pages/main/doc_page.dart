import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DocPage extends StatefulWidget {
  @override
  _DocPageState createState() => _DocPageState();
}

class _DocPageState extends State<DocPage> {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 10.0
          ),
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Container(
                child: ExtendedImage.network(
                  'https://cdn.jsdelivr.net/npm/@bootcss/www.bootcss.com@0.0.2/dist/img/nodejs.png',
                  cache: true,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(20)),
                child: Text('Node.js', style: TextStyle(fontSize: ScreenUtil().setSp(40)),),
              ),
              Container(
                child: Text('一个 JavaScript 编译器。'),
              ),
              Container(
                child: Text('Node.js 使用了一个事件驱动、非阻塞式 I/O 的模型，使其轻量又高效。',),
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Container(
                child: ExtendedImage.network(
                  'https://cdn.jsdelivr.net/npm/@bootcss/www.bootcss.com@0.0.2/dist/img/nodejs.png',
                  cache: true,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(20)),
                child: Text('Node.js', style: TextStyle(fontSize: ScreenUtil().setSp(40)),),
              ),
              Container(
                child: Text('一个 JavaScript 编译器。'),
              ),
              Container(
                child: Text('Node.js 使用了一个事件驱动、非阻塞式 I/O 的模型，使其轻量又高效。',),
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Container(
                child: ExtendedImage.network(
                  'https://cdn.jsdelivr.net/npm/@bootcss/www.bootcss.com@0.0.2/dist/img/nodejs.png',
                  cache: true,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(20)),
                child: Text('Node.js', style: TextStyle(fontSize: ScreenUtil().setSp(40)),),
              ),
              Container(
                child: Text('一个 JavaScript 编译器。'),
              ),
              Container(
                child: Text('Node.js 使用了一个事件驱动、非阻塞式 I/O 的模型，使其轻量又高效。',),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
