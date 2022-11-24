import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigation.dart';
import 'package:flutter_bilibili/page/hometab_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var listener;

  var _controller;
  final List<String> _tabs = ["推荐", "典藏", "美食", "热门", "追博"];

  @override
  void initState() {
    super.initState();
    _controller =
        TabController(initialIndex: 0, length: _tabs.length, vsync: this);
    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      print('main_current:${current.page}');
      print('main_pre:${pre.page}');
      if (widget == current.page || current.page == HomePage) {
        print('打开了首页:onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print('首页:onPause');
      }
    });
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(this.listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.amber,
            tabs: _tabs
                .map((e) => Tab(
                      child: Text(
                        e,
                        style: TextStyle(
                            fontSize: 16, color: Colors.deepOrangeAccent),
                      ),
                    ))
                .toList(),
            controller: _controller,
          ),
          Flexible(
              child: TabBarView(
            children: _tabs
                .map((e) => HomeTabPage(
                      name: e,
                    ))
                .toList(),
            controller: _controller,
          ))
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
