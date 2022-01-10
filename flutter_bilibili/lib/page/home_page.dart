import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  var listener;

  @override
  void initState() {
    super.initState();
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
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text("首页"),
            MaterialButton(
              onPressed: () {
                HiNavigator.getInstance().jumpTo(RouterStatus.detail,
                    args: {'videoMo': VideoModel(1001)});
              },
              child: Text('详情'),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
