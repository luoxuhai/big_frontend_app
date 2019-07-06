import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extended_image/extended_image.dart';
import 'package:big_frontend/components/tag.dart';
import 'package:big_frontend/api/api.dart';

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
  List<String> tabs = ["全部", "Flutter", "React", 'Vue', 'Node', 'MongoDB'];
  List<List> articles = [[], [], [], [], [], []];
  List<int> page = List<int>.generate(6, (i) => 1),
      per_page = List<int>.generate(6, (i) => 5),
      total = List<int>.generate(6, (i) => 1);
  int index = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    loadArticle();
  }

  void loadArticle([reachBottom = false]) {
    if(reachBottom == false) page[index] = 1;
    if (page[index] > total[index]) {
      setState(() {
        loading = false;
      });
      return;
    } else
      setState(() {
        loading = true;
      });
    Api.getArticles({
      'page': page[index],
      'per_page': per_page[index],
      'tag': tabs[index] == '全部' ? 'home' : tabs[index]
    }).then((res) {
      print(res);
      if (page[index] >= res['total'])
        setState(() {
          loading = false;
        });

      if (reachBottom)
        setState(() {
          articles[index].addAll(res['articles']);
        });
      else
        setState(() {
          articles[index] = res['articles'];
        });
      per_page[index] = res['per_page'];
      page[index] = res['page'] + 1;
      total[index] = res['total'] == 0 ? 1 : res['total'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: TabBar(
            onTap: (current) {
              if (articles[current].length == 0 || index == current) {
                index = current;
                loadArticle();
              }
              index = current;
            },
            controller: _tabController,
            isScrollable: true,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabBarView(),
      ),
    );
  }

  List<Widget> tabBarView() {
    int index = 0;
    return tabs.map((e) {
      index++;
      return TabItemView(articles[index - 1]);
    }).toList();
  }
}

class TabItemView extends StatefulWidget {
  List articles = [];

  TabItemView(this.articles);
  @override
  _TabItemViewState createState() => _TabItemViewState();
}

class _TabItemViewState extends State<TabItemView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: ListView.builder(
        itemCount: widget.articles.length,
        itemExtent: ScreenUtil().setWidth(300),
        padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
        addAutomaticKeepAlives: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(40)),
            decoration: BoxDecoration(
                border: BorderDirectional(
                    bottom: BorderSide(color: Color(0xffeeeeee), width: 2))),
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
                        widget.articles[index]['title'],
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(36),
                            fontWeight: FontWeight.w600),
                      ),
                      TagWidget(
                        tagList: [widget.articles[index]['tag']],
                        margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                        tagTextSize: ScreenUtil().setSp(40),
                        tagColor: Colors.pink,
                        tagTextColor: Colors.white,
                      )
                    ],
                  ),
                ),
                ExtendedImage.network(
                  widget.articles[index]['cover'],
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
  }
}
