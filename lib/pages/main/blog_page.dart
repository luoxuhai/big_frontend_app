import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extended_image/extended_image.dart';
import 'package:big_frontend/components/tag.dart';

class BlogPage extends StatefulWidget {
  BlogPage({
    Key key,
  });

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabs = ["全部", "Flutter", "React", 'Vue', 'Node', 'Mongodb'];

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
            isScrollable: true,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e) {
          return Container(
            child: ListView.builder(
              itemCount: 100,
              itemExtent: ScreenUtil().setWidth(300),
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(40)),
                  decoration: BoxDecoration(
                      border: BorderDirectional(
                          bottom:
                              BorderSide(color: Color(0xffeeeeee), width: 2))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().setWidth(520),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Flutter app bar and search widget integrated',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(36),
                                  fontWeight: FontWeight.w600),
                            ),
                            TagWidget(
                              tagList: ['Flutter'],
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setWidth(20)),
                              tagColor: Colors.pink,
                              tagTextColor: Colors.white,
                            )
                          ],
                        ),
                      ),
                      ExtendedImage.network(
                        'https://cdn.jsdelivr.net/npm/@bootcss/www.bootcss.com@0.0.2/dist/img/nodejs.png',
                        width: ScreenUtil().setWidth(155),
                        height: ScreenUtil().setWidth(155),
                        cache: true,
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(20)),
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
