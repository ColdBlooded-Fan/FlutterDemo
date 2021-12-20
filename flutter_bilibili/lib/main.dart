import 'package:flutter/material.dart';
import 'package:flutter_bilibili/db/hi_cache.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/dao/login_dao.dart';
import 'package:flutter_bilibili/http/request/TestRequest.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/page/home_page.dart';
import 'package:flutter_bilibili/page/login_page.dart';
import 'package:flutter_bilibili/page/registration_page.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';
import 'package:flutter_bilibili/util/color.dart';

void main() {
  runApp(BiliApp());
}

class BiliApp extends StatefulWidget {
  @override
  _BiliAppState createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  BiliRouterDelegate _routerDelegate = BiliRouterDelegate();

  @override
  Widget build(BuildContext context) {
    //定义Router
    var widget = Router(routerDelegate: _routerDelegate);
    return MaterialApp(
      home: widget,
    );
  }
}

class BiliRouterDelegate extends RouterDelegate<BiliRouterPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRouterPath> {
  final GlobalKey<NavigatorState> navigatorKey;

  //为navigation设置一个key,必要的时候可以通过navigatorKey.currentState来获取到NavigatorState对象
  BiliRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  List<MaterialPage> pages = [];

  VideoModel videoModel;

  BiliRouterPath path;

  @override
  Widget build(BuildContext context) {
    //构建路由堆栈
    pages = [
      pageWrap(HomePage(onJumpDetail: (data) {
        this.videoModel = data;
        notifyListeners();
      })),
      if (videoModel != null) pageWrap(VideoDetailPage(videoModel: videoModel))
    ];

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        //这里处理是否可以返回上个页面
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BiliRouterPath configuration) {
    this.path = configuration;
  }
}

class BiliRouterPath {
  final String location;

  BiliRouterPath.home() : location = "/";

  BiliRouterPath.detail() : location = "/";
}

///创建页面
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}
