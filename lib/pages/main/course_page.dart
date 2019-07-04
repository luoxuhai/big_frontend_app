import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoursePage extends StatefulWidget {
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller
  List tabs = ['视频', '书籍'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: TabBar(
              controller: _tabController,
              indicatorPadding: EdgeInsets.all(2),
              tabs: tabs.map((e) => Tab(text: e)).toList()),
        ),
        body: TabBarView(
          controller: _tabController,
          children: tabs.map((e) {
            return Container(
              child: ListView.builder(
                  itemCount: 100,
                  itemExtent: ScreenUtil().setWidth(210),
                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: ExtendedImage.network(
                              'https://cdn.jsdelivr.net/npm/@bootcss/www.bootcss.com@0.0.2/dist/img/nodejs.png',
                              width:
                                  ScreenUtil().setWidth(e == '视频' ? 210 : 150),
                              height:
                                  ScreenUtil().setWidth(e == '视频' ? 140 : 200),
                              cache: true,
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().setWidth(20)),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: ScreenUtil().setWidth(450),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '它是列表项的构建器，类型为In',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(36),
                                      fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      '￥258',
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            );
          }).toList(),
        ));
  }
}
