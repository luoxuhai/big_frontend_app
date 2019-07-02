import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:big_frontend/utils/class_builder.dart';
import './main_page.dart';

class MainWidget extends StatefulWidget {
  MainWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('MainPage'),
      items: [
        KFDrawerItem.initWithPage(
          text: Container(),
          page: MainPage(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KFDrawer(
        // borderRadius: 0.0,
        // shadowBorderRadius: 0.0,
        // menuPadding: EdgeInsets.all(0.0),
        scrollable: true,
        controller: _drawerController,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width * 0.6,
            height: 100,
            child: Center(
              child: Text('大前端logo'),
            ),
            color: Colors.amberAccent,
          ),
        ),
        footer: Column(
          children: <Widget>[
            ListTile(
              title: Text('我的收藏'),
              leading: Icon(Icons.star),
            ),
            ListTile(
              title: Text('我的浏览'),
              leading: Icon(Icons.remove_red_eye),
            ),
            ListTile(
              title: Text('设置'),
              leading: Icon(Icons.settings),
            ),
            ListTile(
              title: Text(
                '关于',
              ),
              leading: Icon(Icons.supervised_user_circle),
            ),
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(255, 255, 255, 1.0),
              Color.fromRGBO(44, 72, 171, 1.0)
            ],
            tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }
}
