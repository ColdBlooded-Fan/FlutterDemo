import 'package:flutter/material.dart';
import 'package:flutter_bilibili/navigator/hi_navigation.dart';
import 'package:flutter_bilibili/page/favorite_page.dart';
import 'package:flutter_bilibili/page/home_page.dart';
import 'package:flutter_bilibili/page/profile_page.dart';
import 'package:flutter_bilibili/page/ranking_page.dart';
import 'package:flutter_bilibili/util/color.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = primary;
  int _currentIndex = 0;

  final PageController _controller = PageController(initialPage: 0);

  List<Widget> _pages;

  static int initialPage = 0;
  bool _hasBuild = false;

  @override
  Widget build(BuildContext context) {
    _pages = [HomePage(), RankingPage(), FavoritePage(), ProfilePage()];

    if (!_hasBuild) {
      HiNavigator.getInstance()
          .onBottomTabChanged(initialPage, _pages[initialPage]);
      _hasBuild = true;
    }

    return Scaffold(
      body: PageView(
        controller: _controller,
        children: _pages,
        onPageChanged: (index)=> _onItemTapped(index,pageChange: true),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _bottomItem("首页", Icons.home, 0),
          _bottomItem("排行", Icons.local_fire_department, 1),
          _bottomItem("收藏", Icons.favorite, 2),
          _bottomItem("我的", Icons.live_tv, 3),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) => _onItemTapped(index),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(icon, color: _defaultColor),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ),
        label: title);
  }

  void _onItemTapped(int value,{pageChange = false}) {
    if (value == _currentIndex) return;

    if(!pageChange) {
      _controller.jumpToPage(value);
    }else {
      HiNavigator.getInstance().onBottomTabChanged(value, _pages[value]);
    }

    setState(() {
      _currentIndex = value;
    });
  }
}
