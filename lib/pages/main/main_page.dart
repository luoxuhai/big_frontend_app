import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
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
