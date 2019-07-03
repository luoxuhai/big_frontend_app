import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './blog_page.dart';
import './doc_page.dart';
import './course_page.dart';

class MainPage extends KFDrawerContent {
  MainPage({
    Key key,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  List<Widget> pages = [BlogPage(), DocPage(), CoursePage()];

  @override
  Widget build(BuildContext context) {
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
          ..init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: widget.onMenuPressed,
          );
        }),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        color: Colors.white,
        child: BottomNavyBar(
          showElevation: false,
          selectedIndex: _selectedIndex,
          onItemSelected: (index) => setState(() {
                _selectedIndex = index;
                // _pageController.animateToPage(index,
                //     duration: Duration(milliseconds: 300), curve: Curves.ease);
              }),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.apps),
              title: Text('博客'),
              activeColor: Colors.red,
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.people),
                title: Text('官方文档'),
                activeColor: Colors.purpleAccent),
            BottomNavyBarItem(
                icon: Icon(Icons.message),
                title: Text('精品教程'),
                activeColor: Colors.pink),
          ],
        ),
      ),
    );
  }
}
